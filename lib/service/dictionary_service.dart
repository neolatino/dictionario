import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import 'package:neolatino_dictionario/model/dictionary_entry.dart';
import 'package:neolatino_dictionario/model/language.dart';

const dictionaryUrl =
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vSTGFkqoTOA-Q266tPGtzJ0Giaq2LGpxWtIlp0vYAH46gvxf4qxRIVtbK7bx1epz2SwqEQEQR8GwlLn/pub?gid=0&single=true&output=csv";

class SearchMatch {
  DictionaryEntry entry;
  Language lang;
  int score;

  SearchMatch(this.entry, this.lang, this.score);
}

class DictionaryService {
  DictionaryService._internal();

  static final DictionaryService _singleton = DictionaryService._internal();

  factory DictionaryService() {
    return _singleton;
  }

  final entries = <DictionaryEntry>[];
  var loaded = false;

  Future<void> load() async {
    if (loaded) return;

    final response = await http.get(Uri.parse(dictionaryUrl));
    final document = Utf8Decoder().convert(response.bodyBytes);

    entries.clear();

    final dict = const CsvToListConverter().convert(document, shouldParseNumbers: false).skip(1);

    dict.forEach((it) {
      entries.add(DictionaryEntry(
        int.parse(it[0]),
        "",
        it[3],
        it[6],
        it[7],
        it[8],
        it[9],
        it[12],
        it[14],
        it[15],
      ));
    });

    loaded = true;
    print("#Loaded ${entries.length} dictionary entries");
    print("${entries.firstWhere((element) => element.id == 1402).as(Language.French)}");
  }

  Future<List<SearchMatch>> findEntries(String query) async {
    if (!loaded) await load();

    if (query.isEmpty) return [];
    query = removeDiacritics(query.toLowerCase());

    final matches = entries
        .expand((entry) => Language.values
            .map((lang) => SearchMatch(entry, lang, stringDiff(removeDiacritics(entry.as(lang)), query))))
        .where((match) => match.score == 0)
        .toList();

    matches.sort((a, b) => a.score.compareTo(b.score));

    return matches;
  }

  String categoryName(String cat) {
    switch (cat) {
      case "vt":
        return "verbo transitivo";
      case "sm":
        return "substantivo masculino";
      case "adv":
        return "advèrbio";
      case "adj":
        return "adjectivo";
      case "sf":
        return "substantivo femenino";
      case "prep":
        return "prepositione aut locutione prepositiva";
      case "prep + art":
        return "prepositione et artículo";
      case "inter":
        return "interjectione";
      case "vr":
        return "vèrbo reflexivo";
      case "vrp":
        return "vèrbo reflexivo pronomenale";
      case "prep (adv)":
        return "prepositione considerata advèrbio";
      case "vi":
        return "vèrbo intransitivo";
      case "vti":
        return "vèrbo transitivo et intransitivo";
      case "conj":
        return "conjuntione aut locutione conjuntiva";
      case "pron":
        return "pronome";
      case "vn":
        return "vèrbo non personale";
      case "smf":
        return "substantivo masculino aut femenino";
      case "sfm":
        return "substantivo femenino aut masculino";
      case "va":
        return "vèrbo auxiliare";
      case "art":
        return "artículo";
      case "prep acc":
        return "prepositione accusativo";
    }
    return "";
  }

  int stringDiff(String a, String b) {
    if (a.contains(b)) {
      return (a.length - b.length).abs();
    } else {
      return -1;
    }
  }
}

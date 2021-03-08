import 'package:csv/csv.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';
import 'package:neolatino_dictionary/model/dictionary_entry.dart';
import 'package:neolatino_dictionary/model/language.dart';

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

    loaded = true;

    entries.clear();

    final rawDict = await rootBundle.loadString("assets/dictionary.csv");
    final dict = const CsvToListConverter().convert(rawDict, shouldParseNumbers: false).skip(1);

    dict.forEach((it) {
      entries.add(DictionaryEntry(
        0,
        categoryName(it[1]),
        it[0],
        it[2],
        it[3],
        it[4],
        it[5],
        it[6],
        it[7],
      ));
    });

    print("#Loaded ${entries.length} dictionary entries");
  }

  List<SearchMatch> findEntries(String query) {
    if (query.isEmpty) return [];
    query = removeDiacritics(query.toUpperCase());

    final matches = entries
        .expand((entry) => Language.values
            .map((lang) => SearchMatch(entry, lang, stringDiff(removeDiacritics(entry.as(lang)), query))))
        .where((match) => match.score >= 0)
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

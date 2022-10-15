import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:neolatino_dictionario/dict/dict_entry.dart';

class SearchMatch {
  DictionaryEntry entry;
  int score;

  SearchMatch(this.entry, this.score);
}

class Dictionary {
  final List<DictionaryEntry> entries;

  Dictionary(this.entries);

  List<SearchMatch> search(String query) {
    if (query.isEmpty) return [];
    query = removeDiacritics(query.toLowerCase());

    final matches =
        entries.map((it) => it.getMatch(query)).whereNotNull().toList();

    matches.sort((a, b) => a.score.compareTo(b.score));

    return matches;
  }
}

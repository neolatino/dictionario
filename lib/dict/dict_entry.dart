import 'package:collection/collection.dart';
import 'package:neolatino_dictionario/dict/dict.dart';
import 'package:oxidized/oxidized.dart';

import 'language.dart';

class DictionaryEntry {
  final int id;
  final Option<String> lat;
  final Option<String> iro;
  final Option<String> por;
  final Option<String> spa;
  final Option<String> cat;
  final Option<String> occ;
  final Option<String> fra;
  final Option<String> srd;
  final Option<String> ita;
  final Option<String> rum;
  final Option<String> eng;
  final Option<String> fol;
  final Option<String> fre;
  final Option<String> sla;

  DictionaryEntry(
      this.id,
      this.lat,
      this.iro,
      this.por,
      this.spa,
      this.cat,
      this.occ,
      this.fra,
      this.srd,
      this.ita,
      this.rum,
      this.eng,
      this.fol,
      this.fre,
      this.sla);

  Option<String> as(Language lang) {
    switch (lang) {
      case Language.NeoLatino:
        return lat;
      case Language.LatinoInterRomanico:
        return iro;
      case Language.Portuguese:
        return por;
      case Language.Spanish:
        return spa;
      case Language.Catalan:
        return cat;
      case Language.Occitan:
        return occ;
      case Language.French:
        return fra;
      case Language.Sardinian:
        return srd;
      case Language.Italian:
        return ita;
      case Language.Romanian:
        return rum;
      case Language.English:
        return eng;
      case Language.Folksprak:
        return fol;
      case Language.Frenkisch:
        return fre;
      case Language.InterSlavic:
        return sla;
    }
  }

  List<Language> langs() => Language.values
      .map((lang) => as(lang).map((_) => lang))
      .where((it) => it.isSome())
      .map((it) => it.unwrap())
      .toList();

  SearchMatch? getMatch(String query) {
    final score = Language.values
        .map((it) => as(it).mapOr((it) => stringDiff(it, query), -1))
        .where((element) => element >= 0)
        .minOrNull;

    return (score != null) ? SearchMatch(this, score) : null;
  }

  int stringDiff(String a, String b) {
    if (a.contains(b)) {
      return (a.length - b.length).abs();
    } else {
      return -1;
    }
  }
}

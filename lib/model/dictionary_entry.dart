import 'language.dart';

class DictionaryEntry {
  final int id;
  final String cat;
  final String la;
  final String pt;
  final String es;
  final String ca;
  final String fr;
  final String it;
  final String ro;
  final String en;

  DictionaryEntry(this.id, this.cat, this.la, this.pt, this.es, this.ca, this.fr, this.it, this.ro, this.en);

  String as(Language lang) {
    switch (lang) {
      case Language.NeoLatino:
        return la;
      case Language.Portuguese:
        return pt;
      case Language.Spanish:
        return es;
      case Language.Catalan:
        return ca;
      case Language.French:
        return fr;
      case Language.Italian:
        return it;
      case Language.Romanian:
        return ro;
      case Language.English:
        return en;
    }
  }
}

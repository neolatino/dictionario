// Authentication states
import 'package:neolatino_dictionario/model/language.dart';

abstract class NavigationState {
  static NavigationHomeState home() => NavigationHomeState();

  static NavigationUnknownState unknown() => NavigationUnknownState();

  static NavigationSearchState search(String search) => NavigationSearchState(search);

  static NavigationEntryState entry(int id, Language lang, String word) => NavigationEntryState(id, lang, word);
}

class NavigationHomeState extends NavigationState {}

class NavigationUnknownState extends NavigationState {}

class NavigationSearchState extends NavigationState {
  final String search;

  NavigationSearchState(this.search);
}

class NavigationEntryState extends NavigationState {
  final int id;
  final Language lang;
  final String word;

  NavigationEntryState(this.id, this.lang, this.word);
}

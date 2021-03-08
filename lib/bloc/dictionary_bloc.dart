import 'package:bloc/bloc.dart';
import 'package:neolatino_dictionary/model/dictionary_entry.dart';
import 'package:neolatino_dictionary/model/language.dart';
import 'package:neolatino_dictionary/service/dictionary_service.dart';

/* Events */

abstract class DictionaryEvent {
  static HomeEvent home() => HomeEvent();

  static UnknownEvent unknown() => UnknownEvent();

  static SearchEvent search(String search) => SearchEvent(search);

  static EntryEvent entry(int id, Language lang) => EntryEvent(id, lang);
}

class HomeEvent extends DictionaryEvent {}

class UnknownEvent extends DictionaryEvent {}

class SearchEvent extends DictionaryEvent {
  final String search;

  SearchEvent(this.search);
}

class EntryEvent extends DictionaryEvent {
  final int id;
  final Language lang;

  EntryEvent(this.id, this.lang);
}

/* State */

abstract class DictionaryState {
  static HomeState home() => HomeState();

  static SearchState search(String search, List<SearchMatch> matches) => SearchState(search, matches);

  static EntryState entry(DictionaryEntry entry, Language lang) => EntryState(entry, lang);

  static UnknownState unknown() => UnknownState();
}

class HomeState extends DictionaryState {}

class SearchState extends DictionaryState {
  final String search;
  final List<SearchMatch> matches;

  SearchState(this.search, this.matches);
}

class EntryState extends DictionaryState {
  final DictionaryEntry entry;
  final Language lang;

  EntryState(this.entry, this.lang);
}

class UnknownState extends DictionaryState {}
/* Bloc */

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final service = DictionaryService();

  DictionaryBloc() : super(DictionaryState.home());

  @override
  Stream<DictionaryState> mapEventToState(DictionaryEvent event) async* {
    print("mapEventToState $event");
    if (event is HomeEvent) {
      yield DictionaryState.home();
    }
    if (event is SearchEvent) {
      yield DictionaryState.search(event.search, []);
    }

    //final entries = service.findEntries(event.query);
    //print("Found ${entries.length} entries");
    //yield DictionaryState.search(event.query, entries);
  }
}

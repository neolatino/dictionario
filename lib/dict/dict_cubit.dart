import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:neolatino_dictionario/dict/dict.dart';
import 'package:neolatino_dictionario/dict/dict_entry.dart';
import 'package:oxidized/oxidized.dart';

const dictionaryUrl =
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vSGCRUv8z5VSCk7lBy_4gtH2PkFvMH5ny65qauUmYzqWinGEw23IAQT_1seyBGfqw/pub?gid=1315031947&single=true&output=csv";

class DictionaryState {
  final bool loaded;
  final Option<Dictionary> dictionary;
  final Option<List<SearchMatch>> matches;
  final Option<String> query;

  DictionaryState(
      {required this.loaded,
      required this.dictionary,
      required this.matches,
      required this.query});

  DictionaryState.init()
      : loaded = false,
        matches = None(),
        query = None(),
        dictionary = None();

  DictionaryState copyWith(
          {bool? loaded,
          Option<Dictionary>? dictionary,
          Option<List<SearchMatch>>? matches,
          Option<String>? query}) =>
      DictionaryState(
        loaded: loaded ?? this.loaded,
        dictionary: dictionary ?? this.dictionary,
        matches: matches ?? this.matches,
        query: query ?? this.query,
      );
}

class DictionaryCubit extends Cubit<DictionaryState> {
  DictionaryCubit() : super(DictionaryState.init()) {
    fetch();
    //fetchMock();
  }

  void query(String query) {
    emit(state.copyWith(
      matches: None(),
      query: Some(query),
    ));
  }

  void search(String query) {
    emit(state.copyWith(
      matches: state.dictionary.map((it) => it.search(query)),
      query: Some(query),
    ));
  }

  void reset() => emit(state.copyWith(
        matches: None(),
        query: None(),
      ));

  void fetch() async {
    final response = await http.get(Uri.parse(dictionaryUrl));
    final document = Utf8Decoder().convert(response.bodyBytes);

    final csv = const CsvToListConverter()
        .convert(document, shouldParseNumbers: false)
        .skip(3)
        .toList();


    List<DictionaryEntry> entries = List.empty(growable: true);

    for (final it in csv) {
      try {
        final entry = DictionaryEntry(
          int.parse(it[0]),
          it[2],
          it[3],
          it[4],
          it[5],
          stringToOption(it[8]),
          stringToOption(it[9]),
          stringToOption(it[10]),
          stringToOption(it[11]),
          stringToOption(it[12]),
          stringToOption(it[13]),
          stringToOption(it[14]),
          stringToOption(it[15]),
          stringToOption(it[16]),
          stringToOption(it[17]),
          stringToOption(it[18]),
          stringToOption(it[19]),
          stringToOption(it[20]),
          stringToOption(it[21]),
        );

        entries.add(entry);
      } catch (e) {
        print("Error: can't parse entry $it");
      }
    }

    emit(state.copyWith(dictionary: Some(Dictionary(entries))));
    if (state.query.isSome()) search(state.query.unwrap());
  }

  void fetchMock() async {
    final entries = [
      DictionaryEntry(
        0,
        "adj.",
        "grammàtica",
        "alfabèto",
        "altras",
        Some("mangare"),
        Some("mangere"),
        None(),
        None(),
        Some("comer"),
        None(),
        Some("manger"),
        None(),
        None(),
        None(),
        None(),
        None(),
        Some("manger"),
        Some("manger"),
      )
    ];

    emit(state.copyWith(dictionary: Some(Dictionary(entries))));
    if (state.query.isSome()) search(state.query.unwrap());
  }

  Option<String> stringToOption(String s) => s.isEmpty ? None() : Some(s);
}

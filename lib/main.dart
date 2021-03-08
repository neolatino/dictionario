import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionary/bloc/dictionary_bloc.dart';

import 'ui/App.dart';

// URL Dictionnaire
// https://docs.google.com/spreadsheets/d/e/2PACX-1vSTGFkqoTOA-Q266tPGtzJ0Giaq2LGpxWtIlp0vYAH46gvxf4qxRIVtbK7bx1epz2SwqEQEQR8GwlLn/pub?gid=0&single=true&output=csv

void main() {
  runApp(
    BlocProvider(
      create: (context) => DictionaryBloc(),
      child: NeolatinoApp(),
    ),
  );
}

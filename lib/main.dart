import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionario/bloc/dictionary_bloc.dart';

import 'ui/App.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => DictionaryBloc(),
      child: NeolatinoApp(),
    ),
  );
}

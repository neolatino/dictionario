import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionario/bloc/dictionary_bloc.dart';
import 'package:neolatino_dictionario/navigation/UrlHandlerInformationParser.dart';
import 'package:neolatino_dictionario/navigation/UrlHandlerRouterDelegate.dart';

class NeolatinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dictionario Neolatino',
      routerDelegate: UrlHandlerRouterDelegate(BlocProvider.of<DictionaryBloc>(context)), // TODO : Pass down the bloc
      routeInformationParser: UrlHandlerInformationParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}

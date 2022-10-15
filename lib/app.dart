import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neolatino_dictionario/dict/dict_cubit.dart';
import 'package:neolatino_dictionario/router.dart';

class DictionarioApp extends StatelessWidget {
  DictionarioApp({Key? key}) : super(key: key);

  final GoRouter _router = router();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DictionaryCubit>(
      create: (BuildContext context) => DictionaryCubit(),
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'Dictionario Neolatino',
      ),
    );
  }
}

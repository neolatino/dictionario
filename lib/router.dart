import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neolatino_dictionario/dict/dict_cubit.dart';
import 'package:neolatino_dictionario/search/search_page.dart';
import 'package:neolatino_dictionario/widget/home.dart';
import 'package:neolatino_dictionario/widget/preloader.dart';

CustomTransitionPage<T> defaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration(milliseconds: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

GoRouter router() => GoRouter(
      errorPageBuilder: (BuildContext context, GoRouterState state) =>
          defaultTransition(
              context: context,
              state: state,
              child: PreLoader(child: HomePage())),
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              defaultTransition(
                  context: context,
                  state: state,
                  child: PreLoader(child: HomePage())),
        ),
        GoRoute(
          path: '/search/:query',
          pageBuilder: (BuildContext context, GoRouterState state) {
            final query = state.params['query'];
            if (query != null)
              BlocProvider.of<DictionaryCubit>(context).search(query);

            return defaultTransition(
              context: context,
              state: state,
              child: PreLoader(
                child: SearchPage(),
              ),
            );
          },
        ),
      ],
    );

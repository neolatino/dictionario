import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionary/bloc/dictionary_bloc.dart';
import 'package:neolatino_dictionary/navigation/NavigationState.dart';
import 'package:neolatino_dictionary/ui/widget/HomePage.dart';

final GlobalKey<NavigatorState> _urlHandlerRouterDelegateNavigatorKey = GlobalKey<NavigatorState>();

class UrlHandlerRouterDelegate extends RouterDelegate<NavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final DictionaryBloc bloc;

  UrlHandlerRouterDelegate(this.bloc) {
    bloc.listen((state) {
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        pages: [
          MaterialPage(
            child: BlocBuilder<DictionaryBloc, DictionaryState>(
              builder: (BuildContext context, state) {
                var newState;
                if (state is HomeState) newState = HomePage();
                if (state is SearchState) newState = HomePage();
                if (state is EntryState) newState = HomePage();
                if (state is UnknownState) newState = HomePage();

                return newState;
              },
            ),
          ),
        ],
        onPopPage: (_, __) {
          // We don't handle routing logic here, so we just return false
          return false;
        },
      ),
    );
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _urlHandlerRouterDelegateNavigatorKey;

  // Navigation state to app state
  @override
  Future<void> setNewRoutePath(NavigationState navigationState) async {
    print("setNewRoutePath $navigationState");

    if (navigationState is NavigationHomeState) bloc.add(DictionaryEvent.home());
    if (navigationState is NavigationSearchState) bloc.add(DictionaryEvent.search(navigationState.search));
    if (navigationState is NavigationEntryState)
      bloc.add(DictionaryEvent.entry(navigationState.id, navigationState.lang));
    if (navigationState is NavigationUnknownState) bloc.add(DictionaryEvent.unknown());

    notifyListeners();
  }

  // App state to Navigation state, triggered by notifyListeners()
  @override
  NavigationState get currentConfiguration => makeNavigationState();

  NavigationState makeNavigationState() {
    print("currentConfiguration ${bloc.state}");

    var s = bloc.state;
    if (s is HomeState) return NavigationHomeState();
    if (s is SearchState) return NavigationSearchState(s.search);
    if (s is EntryState) return NavigationEntryState(s.entry.id, s.lang, s.entry.as(s.lang));
    if (s is UnknownState) return NavigationUnknownState();

    return NavigationUnknownState();
  }
}

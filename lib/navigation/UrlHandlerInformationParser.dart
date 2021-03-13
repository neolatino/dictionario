import 'package:flutter/material.dart';
import 'package:neolatino_dictionario/model/language.dart';
import 'package:neolatino_dictionario/navigation/NavigationState.dart';

class UrlHandlerInformationParser extends RouteInformationParser<NavigationState> {
  // Url to navigation state
  @override
  Future<NavigationState> parseRouteInformation(RouteInformation routeInformation) async {
    print(routeInformation.location);
    print("parseRouteInformation ${routeInformation.location}");

    final uri = Uri.parse(routeInformation.location ?? "/");
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return NavigationState.home();
    }

    if (uri.pathSegments[0] == "search") {
      if (uri.pathSegments.length != 2) return NavigationState.unknown();
      var search = uri.pathSegments[1];
      return NavigationState.search(search);
    }

    if (uri.pathSegments[0] == "word") {
      if (uri.pathSegments.length != 4) return NavigationState.unknown();
      try {
        var id = int.parse(uri.pathSegments[1]);
        var lang = LanguageExt.fromCode(uri.pathSegments[2]);
        var word = uri.pathSegments[3];
        return NavigationState.entry(id, lang, word);
      } catch (e) {
        return NavigationState.unknown();
      }
    }
    return NavigationState.unknown();
  }

  // Navigation state to url
  @override
  RouteInformation restoreRouteInformation(NavigationState navigationState) {
    print("restoreRouteInformation $navigationState");

    if (navigationState is NavigationHomeState) return RouteInformation(location: '/');
    if (navigationState is NavigationUnknownState) return RouteInformation(location: '/404');
    if (navigationState is NavigationSearchState)
      return RouteInformation(location: '/search/${navigationState.search}');
    if (navigationState is NavigationEntryState)
      return RouteInformation(
          location: '/word/${navigationState.id}/${navigationState.lang.code()}/${navigationState.word}');
    else
      return RouteInformation(location: '/');
  }
}

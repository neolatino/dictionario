import 'package:flutter/material.dart';
import 'package:neolatino_dictionario/bloc/dictionary_bloc.dart';
import 'package:neolatino_dictionario/config/Style.dart';
import 'package:neolatino_dictionario/model/language.dart';
import 'package:neolatino_dictionario/service/dictionary_service.dart';
import 'package:neolatino_dictionario/ui/widget/LanguageIcon.dart';
import 'package:neolatino_dictionario/ui/widget/SitePage.dart';

class SearchPage extends StatelessWidget {
  final SearchState state;

  const SearchPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SitePage(
      withHome: true,
      withSearch: true,
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        itemCount: state.matches.length,
        itemBuilder: (context, index) {
          return match(state.matches[index]);
        },
      ),
    );
  }

  Widget match(SearchMatch match) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SizedBox(
          width: 550,
          child: Container(
            decoration: BoxDecoration(
              color: Style.colorSurface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: match.lang != Language.NeoLatino,
                    child: Row(
                      children: [
                        SizedBox(height: 40, child: LanguageIcon(language: match.lang)),
                        SizedBox(width: 20),
                        Flexible(
                          child: SelectableText(
                            match.entry.as(match.lang),
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Style.colorOnSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: match.lang != Language.NeoLatino,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      child: Container(
                        height: 20.0,
                        decoration:
                            BoxDecoration(border: Border(left: BorderSide(width: 2.0, color: Style.colorOnSurface))),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(height: 40, child: LanguageIcon(language: Language.NeoLatino)),
                      SizedBox(width: 20),
                      Flexible(
                        child: SelectableText(
                          match.entry.as(Language.NeoLatino),
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Style.colorOnSurface,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

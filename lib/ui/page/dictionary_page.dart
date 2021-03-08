import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neolatino_dictionary/bloc/dictionary_bloc.dart';
import 'package:neolatino_dictionary/model/language.dart';
import 'package:neolatino_dictionary/service/dictionary_service.dart';
import 'package:neolatino_dictionary/ui/page/match_page.dart';
import 'package:neolatino_dictionary/ui/styles.dart';
import 'package:neolatino_dictionary/ui/widget/language_icon.dart';

class DictionaryPage extends StatefulWidget {
  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: AppStyles.colorSecondary,
          child: SafeArea(
            child: buildSearchBar(context),
          ),
        ),
        buildBody(context),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              style: TextStyle(fontSize: 20, color: AppStyles.colorOnSurface),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Cercare...",
              ),
              onChanged: (query) => BlocProvider.of<DictionaryBloc>(context).add(DictionaryEvent(query)),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppStyles.colorSurface,
        child: BlocBuilder<DictionaryBloc, DictionaryState>(builder: (context, state) {
          if (state.matches.isNotEmpty) {
            return buildResultList(context, state.matches);
          } else {
            return Center(
              child: Icon(
                Icons.search,
                color: AppStyles.colorSecondary.withAlpha(150),
                size: 200.0,
              ),
            );
          }
        }),
      ),
    );
  }

  Widget buildResultList(BuildContext context, List<SearchMatch> matches) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MatchPage(matches[index])),
        ),
        child: buildEntry(context, matches[index]),
      ),
      padding: EdgeInsets.only(top: 8.0),
    );
  }

  Widget buildEntry(BuildContext context, SearchMatch match) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: AppStyles.colorSurface,
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: LanguageIcon(language: match.lang),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        match.entry.as(match.lang),
                        style: TextStyle(color: AppStyles.colorOnSurface, fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Visibility(
                    visible: match.lang != Language.NeoLatino,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.forum,
                          size: 20.0,
                          color: AppStyles.colorPrimary,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          match.entry.as(Language.NeoLatino),
                          style:
                              TextStyle(color: AppStyles.colorOnSurface, fontStyle: FontStyle.italic, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: match.lang != Language.NeoLatino,
                    child: SizedBox(height: 8.0),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 4.0),
                      Text(
                        match.entry.cat,
                        style: TextStyle(color: AppStyles.colorOnSurface, fontStyle: FontStyle.italic, fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.keyboard_arrow_right, color: AppStyles.colorPrimary)
            ],
          ),
        ),
      ),
    );
  }
}

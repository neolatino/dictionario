import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neolatino_dictionary/model/language.dart';
import 'package:neolatino_dictionary/service/dictionary_service.dart';
import 'package:neolatino_dictionary/ui/styles.dart';
import 'package:neolatino_dictionary/ui/widget/language_icon.dart';

class MatchPage extends StatefulWidget {
  final SearchMatch match;

  MatchPage(this.match);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.colorSecondary,
        leading: BackButton(
          color: AppStyles.colorOnSecondary,
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          buildHeader(context),
          Divider(
            height: 48,
            thickness: 2,
            color: AppStyles.colorPrimary,
          ),
          buildLanguages(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.match.lang != Language.NeoLatino,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: LanguageIcon(language: widget.match.lang),
              ),
              SizedBox(width: 8.0),
              Text(
                widget.match.entry.as(widget.match.lang),
                style: TextStyle(color: AppStyles.colorOnSurface, fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.match.lang != Language.NeoLatino,
          child: Padding(
            padding: EdgeInsets.only(left: 11.0),
            child: Container(
              height: 20.0,
              decoration: BoxDecoration(border: Border(left: BorderSide(width: 2.0, color: AppStyles.colorPrimary))),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.0,
              width: 24.0,
              child: LanguageIcon(language: Language.NeoLatino),
            ),
            SizedBox(width: 8.0),
            Text(
              widget.match.entry.as(Language.NeoLatino),
              style: TextStyle(color: AppStyles.colorOnSurface, fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Icon(
              Icons.description,
              size: 20.0,
              color: AppStyles.colorPrimary,
            ),
            SizedBox(width: 4.0),
            Text(
              widget.match.entry.cat,
              style: TextStyle(color: AppStyles.colorOnSurface, fontStyle: FontStyle.italic, fontSize: 20.0),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLanguages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Altras lenguas :",
            style: TextStyle(color: AppStyles.colorOnSurface, fontSize: 20.0),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16.0),
          decoration: BoxDecoration(border: Border(left: BorderSide(color: AppStyles.colorPrimary, width: 2.0))),
          child: Column(
            children: Language.values
                .where((l) => l != Language.NeoLatino && l != widget.match.lang)
                .map(
                  (l) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: LanguageIcon(language: l),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          widget.match.entry.as(l),
                          style:
                              TextStyle(color: AppStyles.colorOnSurface, fontWeight: FontWeight.bold, fontSize: 25.0),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

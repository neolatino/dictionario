import 'package:flutter/material.dart';
import 'package:neolatino_dictionario/config/Style.dart';
import 'package:neolatino_dictionario/ui/widget/Header.dart';

class SitePage extends StatelessWidget {
  final Widget body;
  final bool withHome;
  final bool withSearch;

  const SitePage({
    Key? key,
    required this.body,
    this.withHome = false,
    this.withSearch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Style.colorPrimary, Style.DarkerPink],
            ),
          ),
          child: Column(
            children: <Widget>[
              Header(
                withHome: withHome,
                withSearch: withSearch,
              ),
              Expanded(
                child: body,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "BETA",
            style: TextStyle(
              fontSize: 20.0,
              color: Style.colorOnPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

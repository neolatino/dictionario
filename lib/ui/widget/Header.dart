import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neolatino_dictionario/bloc/dictionary_bloc.dart';
import 'package:neolatino_dictionario/config/Config.dart';
import 'package:neolatino_dictionario/config/Style.dart';
import 'package:neolatino_dictionario/ui/widget/Searchbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget {
  final bool withHome;
  final bool withSearch;

  const Header({
    Key? key,
    required this.withHome,
    required this.withSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        //color: Style.colorSecondary,
        decoration: withHome || withSearch
            ? BoxDecoration(
                color: Style.colorSecondary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              left(context),
              right(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget left(BuildContext context) {
    return Row(
      children: [
        if (withHome)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: MaterialButton(
              onPressed: () => BlocProvider.of<DictionaryBloc>(context).add(DictionaryEvent.home()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "NEOLATINO",
                    style: GoogleFonts.headlandOne(
                      fontSize: 23.0,
                      color: Style.colorAccent,
                    ),
                  ),
                  Text(
                    "DICTIONARIO",
                    style: GoogleFonts.headlandOne(
                      fontSize: 8.0,
                      color: Style.colorOnPrimary,
                    ).copyWith(letterSpacing: 8.6),
                  ),
                ],
              ),
            ),
          ),
        if (withSearch)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              constraints: BoxConstraints(maxWidth: 550),
              child: Searchbar(),
            ),
          ),
      ],
    );
  }

  Widget right(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          child: Text(
            "Sito Officiale",
            style: TextStyle(
              fontSize: 18.0,
              color: Style.colorOnPrimary,
            ),
          ),
          onPressed: () {
            launch(Config.OfficialWebsite);
          },
        ),
        separator(context),
        IconButton(
          iconSize: 35,
          padding: EdgeInsets.zero,
          icon: FaIcon(
            FontAwesomeIcons.github,
            color: Style.colorOnSecondary,
          ),
          onPressed: () {
            launch(Config.GithubUrl);
          },
        ),
      ],
    );
  }

  Widget separator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SizedBox(
        height: 30,
        child: VerticalDivider(color: Style.colorOnPrimary),
      ),
    );
  }
}

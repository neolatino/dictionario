import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neolatino_dictionario/style.dart';
import 'package:neolatino_dictionario/widget/page.dart';
import 'package:neolatino_dictionario/widget/searchbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "NEOLATINO",
            style: GoogleFonts.headlandOne(
              fontSize: 80.0,
              color: Style.colorAccent,
            ),
          ),
          Text(
            "DICTIONARIO",
            style: GoogleFonts.headlandOne(
              fontSize: 25.0,
              color: Style.colorOnPrimary,
            ).copyWith(letterSpacing: 32),
          ),
          SizedBox(height: 100.0),
          Container(
            constraints: BoxConstraints(maxWidth: 550),
            child: Searchbar(),
          ),
          SizedBox(height: 500.0),
        ],
      ),
    );
  }
}

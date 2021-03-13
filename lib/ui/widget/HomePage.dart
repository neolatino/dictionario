import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neolatino_dictionario/config/Style.dart';
import 'package:neolatino_dictionario/ui/widget/Searchbar.dart';
import 'package:neolatino_dictionario/ui/widget/SitePage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SitePage(
      body: Column(
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
              fontSize: 20.0,
              color: Style.colorOnPrimary,
            ).copyWith(letterSpacing: 36),
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

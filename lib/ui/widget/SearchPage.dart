import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neolatino_dictionary/ui/styles.dart';
import 'package:neolatino_dictionary/ui/widget/Searchbar.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppStyles.Burgundy, AppStyles.DarkBurgundy],
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "NEOLATINO",
            style: GoogleFonts.headlandOne(
              fontSize: 80.0,
              color: AppStyles.colorOnPrimary,
            ),
          ),
          Text(
            "DICTIONARIO",
            style: GoogleFonts.headlandOne(
              fontSize: 20.0,
              color: AppStyles.colorOnPrimary,
            ).copyWith(letterSpacing: 36),
          ),
          SizedBox(height: 100.0),
          Container(
            constraints: BoxConstraints(maxWidth: 550),
            child: Searchbar(),
          ),
          SizedBox(height: 300.0),
        ],
      ),
    );
  }
}

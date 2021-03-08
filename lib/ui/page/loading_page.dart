import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neolatino_dictionary/ui/styles.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppStyles.colorSecondary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "NEOLATINO",
                style: GoogleFonts.headlandOne(
                  fontSize: 40.0,
                  color: AppStyles.colorOnPrimary,
                ),
              ),
              SizedBox(height: 160.0),
              SpinKitFadingCube(
                color: AppStyles.colorOnPrimary,
                size: 40.0,
                duration: const Duration(milliseconds: 2400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neolatino_dictionary/ui/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyles.colorSecondary,
      child: SafeArea(
        child: Container(
          color: AppStyles.colorSurface,
          child: buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage("assets/neolatino.png"),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Cuesta applicatione informàtica cerca paraulas en lo Dictionario Essentiale Neolatino.",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppStyles.colorOnSurface,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Plus de informationes :",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppStyles.colorOnSurface,
                  ),
                ),
                SizedBox(height: 16.0),
                RaisedButton(
                  padding: EdgeInsets.all(8.0),
                  color: AppStyles.colorSecondary,
                  child: Text(
                    "Lòco web",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppStyles.colorOnPrimary,
                    ),
                  ),
                  onPressed: goToWebsite,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(8.0),
                  color: AppStyles.colorSecondary,
                  child: Text(
                    "Pàgina Facebook",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppStyles.colorOnPrimary,
                    ),
                  ),
                  onPressed: goToFacebook,
                ),
                SizedBox(height: 32.0),
                Text(
                  "Desveloppatore: Florian Poncabaré",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppStyles.colorOnSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  goToWebsite() async {
    const url = 'https://www.neolatino.eu';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  goToFacebook() async {
    const url = 'https://www.facebook.com/vianeolatina/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

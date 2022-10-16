import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neolatino_dictionario/config.dart';
import 'package:neolatino_dictionario/style.dart';
import 'package:neolatino_dictionario/widget/header.dart';
import 'package:url_launcher/url_launcher.dart';

class PageTemplate extends StatelessWidget {
  final Widget? content;
  final Widget? header;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageTemplate({Key? key, this.content, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Config.isWebMobile() && header != null
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu, size: 40), // change this size and style
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              toolbarHeight: 70,
              backgroundColor: Style.colorSurface,
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: header,
              ),
            )
          : null,
      drawer: Config.isWebMobile()
          ? Drawer(
              child: socialLinksVertical(context),
            )
          : null,
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          inner(context, content),
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
      ),
    );
  }

  Widget inner(BuildContext context, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Style.colorPrimary, Style.DarkerPink],
        ),
      ),
      child: Column(
        children: <Widget>[
          if (!Config.isWebMobile())
            Header(
              custom: header,
            ),
          Expanded(
            child: child ?? Container(),
          ),
        ],
      ),
    );
  }

  Widget socialLinksVertical(BuildContext context) {
    return Container(
      color: Style.colorSurface,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          socialLink("Sito Officiale", Config.OfficialWebsiteUrl),
          separator(),
          socialIcon("Discord", FontAwesomeIcons.discord, Config.DiscordUrl),
          separator(),
          socialIcon("Reddit", FontAwesomeIcons.reddit, Config.RedditUrl),
          separator(),
          socialIcon("Github", FontAwesomeIcons.github, Config.GithubUrl),
        ],
      ),
    );
  }

  Widget separator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Divider(color: Style.colorOnPrimary),
    );
  }

  Widget socialLink(String label, String url) {
    return TextButton(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18.0,
          color: Style.colorOnPrimary,
        ),
      ),
      onPressed: () {
        launchUrl(Uri.parse(url));
      },
    );
  }

  Widget socialIcon(String label, IconData icon, String url) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            color: Style.colorOnPrimary,
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          iconSize: 35,
          padding: EdgeInsets.zero,
          icon: FaIcon(
            icon,
            color: Style.colorOnSecondary,
          ),
          onPressed: () {
            launchUrl(Uri.parse(url));
          },
        ),
      ],
    );
  }
}

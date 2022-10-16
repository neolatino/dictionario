import 'package:flutter/cupertino.dart';

abstract class Config {
  static const GithubUrl = "https://github.com/neolatino/dictionario";
  static const OfficialWebsiteUrl = "https://neolatino.eu/";
  static const RedditUrl = "https://www.reddit.com/r/neolatino";
  static const DiscordUrl = "https://discord.gg/x2TyYKWx9V";

  static bool isWebMobile() => false;
  // kIsWeb &&
  // (defaultTargetPlatform == TargetPlatform.iOS ||
  //     defaultTargetPlatform == TargetPlatform.android);

  static T responsive<T>(T mobile, T desktop) =>
      isWebMobile() ? mobile : desktop;

  static double responsiveWidth(BuildContext context, double size) {
    final w = MediaQuery.of(context).size.width;
    final t = (w - 500.0) / 1200.0;
    return (1 - t) * (size * 0.8) + t * size;
  }

  static double responsiveHeight(BuildContext context, double size) {
    final w = MediaQuery.of(context).size.height;
    final t = (w - 800.0) / 600.0;
    return (1 - t) * (size * 0.8) + t * size;
  }
}

import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  final Future action;
  final Widget loader;
  final Widget content;

  SplashScreen({required this.action, required this.loader, required this.content});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool loaded;

  @override
  void initState() {
    this.loaded = false;
    super.initState();

    widget.action.then(
      (_) => setState(() {
        print("Loaded");
        this.loaded = true;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      print("Content");
      return widget.content;
    } else {
      print("Loader");
      return widget.loader;
    }
  }
}

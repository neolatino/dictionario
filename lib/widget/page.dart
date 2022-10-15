import 'package:flutter/material.dart';
import 'package:neolatino_dictionario/style.dart';
import 'package:neolatino_dictionario/widget/header.dart';

class PageTemplate extends StatelessWidget {
  final Widget? content;
  final Widget? header;

  const PageTemplate({Key? key, this.content, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}

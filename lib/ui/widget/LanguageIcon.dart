import 'package:flutter/material.dart';
import 'package:neolatino_dictionario/config/Style.dart';
import 'package:neolatino_dictionario/model/language.dart';

class LanguageIcon extends StatelessWidget {
  final Language language;

  const LanguageIcon({Key? key, required this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Style.colorOnSurface,
          width: 2,
        ),
      ),
      child: Image.asset(
        language.icon(),
        fit: BoxFit.fill,
      ),
    );
  }
}

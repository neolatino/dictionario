import 'package:flutter/material.dart';
import 'package:neolatino_dictionary/model/language.dart';

import '../styles.dart';

class LanguageIcon extends StatelessWidget {
  final Language language;

  const LanguageIcon({Key? key, required this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppStyles.colorPrimary,
          width: 1,
        ),
      ),
      child: Image.asset(
        language.icon(),
        fit: BoxFit.fill,
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum Language {
  NeoLatino,
  LatinoInterRomanico,
  Portuguese,
  Spanish,
  Catalan,
  Occitan,
  French,
  Sardinian,
  Italian,
  Romanian,
  English,
  Folksprak,
  Frenkisch,
  InterSlavic,
}

extension LanguageExt on Language {
  static final languageCode = {
    Language.NeoLatino: "lat",
    Language.LatinoInterRomanico: "iro",
    Language.Portuguese: "por",
    Language.Spanish: "spa",
    Language.Catalan: "cat",
    Language.Occitan: "oci",
    Language.French: "fra",
    Language.Sardinian: "srd",
    Language.Italian: "ita",
    Language.Romanian: "rum",
    Language.English: "eng",
    Language.Folksprak: "fol",
    Language.Frenkisch: "fre",
    Language.InterSlavic: "sla",
  };

  static final languageName = {
    Language.NeoLatino: "Neolatino",
    Language.LatinoInterRomanico: "Interromanico",
    Language.Portuguese: "Portughese",
    Language.Spanish: "Castellano",
    Language.Catalan: "Catalano",
    Language.Occitan: "Occitano",
    Language.French: "Francese",
    Language.Sardinian: "Sardo",
    Language.Italian: "Italiano",
    Language.Romanian: "Rumeno",
    Language.English: "Anglese",
    Language.Folksprak: "Folksprak",
    Language.Frenkisch: "Frenkisch",
    Language.InterSlavic: "Interslavo",
  };

  static final languageColor = {
    Language.NeoLatino: Colors.red.shade800,
    Language.LatinoInterRomanico: Colors.deepOrange.shade800,
    Language.Portuguese: Colors.amber.shade700,
    Language.Spanish: Colors.amber.shade700,
    Language.Catalan: Colors.amber.shade700,
    Language.Occitan: Colors.amber.shade700,
    Language.French: Colors.amber.shade700,
    Language.Sardinian: Colors.amber.shade700,
    Language.Italian: Colors.amber.shade700,
    Language.Romanian: Colors.amber.shade700,
    Language.English: Colors.green.shade700,
    Language.Folksprak: Colors.green.shade700,
    Language.Frenkisch: Colors.green.shade700,
    Language.InterSlavic: Colors.indigo,
  };

  static Language fromCode(String code) {
    return Language.values
        .firstWhere((element) => code == languageCode[element]);
  }

  String icon() => "assets/icons/${languageCode[this]}.png";

  String code() => languageCode[this]!;

  String name() => languageName[this]!;

  Color color() => languageColor[this]!;

  Widget widget() => Container(
        decoration: BoxDecoration(
          color: color(),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Center(
            child: Text(
              name(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
}

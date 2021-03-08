enum Language { NeoLatino, Portuguese, Spanish, Catalan, French, Italian, Romanian }

extension LanguageExt on Language {
  static final languageCode = {
    Language.NeoLatino: "la",
    Language.Portuguese: "pt",
    Language.Spanish: "es",
    Language.Catalan: "ca",
    Language.French: "fr",
    Language.Italian: "it",
    Language.Romanian: "ro"
  };

  static Language fromCode(String code) {
    return Language.values.firstWhere((element) => code == languageCode[element]);
  }

  String icon() => "assets/icons/${languageCode[this]}.png";

  String dict() => "assets/dict/${languageCode[this]}.csv";

  String code() => "${languageCode[this]}";
}

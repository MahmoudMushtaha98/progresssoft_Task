class LanguageModel {
  final int id;
  final String name;
  final String languageCode;

  LanguageModel(this.id, this.name, this.languageCode);

  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel(1, 'English', 'en'),
      LanguageModel(2, 'Arabic', 'ar'),
    ];
  }
}

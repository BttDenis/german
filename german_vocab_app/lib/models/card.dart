class VocabCard {
  final int id;
  final String germanWord;
  final String englishTranslation;
  final String usageExample;
  final String imageBase64;
  final String audioBase64;

  VocabCard({
    required this.id,
    required this.germanWord,
    required this.englishTranslation,
    required this.usageExample,
    required this.imageBase64,
    required this.audioBase64,
  });

  factory VocabCard.fromJson(Map<String, dynamic> json) {
    return VocabCard(
      id: json['id'] as int,
      germanWord: json['german_word'] as String,
      englishTranslation: json['english_translation'] as String,
      usageExample: json['usage_example'] as String,
      imageBase64: json['image_base64'] as String,
      audioBase64: json['audio_base64'] as String,
    );
  }
}

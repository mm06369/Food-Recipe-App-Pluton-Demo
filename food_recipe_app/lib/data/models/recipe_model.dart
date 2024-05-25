class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final String imageType;

  Recipe({required this.id, required this.title, required this.imageUrl, required this.imageType});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      imageType: json['imageType'],
    );
  }
}

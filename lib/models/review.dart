
class Review {
  String author;
  String username;
  String? avatarPath;
  double? rating;
  String content;
  DateTime createdAt;

  Review({
    required this.author,
    required this.username,
    required this.avatarPath,
    required this.rating,
    required this.content,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'],
      username: json['author_details']['username'],
      avatarPath: json['author_details']['avatar_path'],
      rating: json['author_details']['rating'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

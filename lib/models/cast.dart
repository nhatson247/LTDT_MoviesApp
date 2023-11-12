

class Cast {
  int id;
  String name;
  String? profilePath;

  Cast({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json["id"],
      name: json["name"],
      profilePath: json["profile_path"],
    );
  }
}

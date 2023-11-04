class People {
  String name;
  String profilePath;

  People({
    required this.name,
    required this.profilePath,
  });

  factory People.fromJson(Map<String, dynamic> json) {
    return People(
      name: json["name"],
      profilePath: json["profile_path"],
    );
  }
}

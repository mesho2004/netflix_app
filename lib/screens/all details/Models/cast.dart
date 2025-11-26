class Casting {
  final String name;
  final String character;
  final String? profilePath;

  Casting({
    required this.name,
    required this.character,
    this.profilePath,
  });

  factory Casting.fromJson(Map<String, dynamic> json) {
    return Casting(
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'],
    );
  }
}
class Episode {
  final int id;
  final String name;
  final String overview;
  final String? stillPath;
  final int episodeNumber;
  final double voteAverage;
  final String airDate;
  final int runtime;

  Episode({
    required this.id,
    required this.name,
    required this.overview,
    this.stillPath,
    required this.episodeNumber,
    required this.voteAverage,
    required this.airDate,
    required this.runtime,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      stillPath: json['still_path'],
      episodeNumber: json['episode_number'],
      voteAverage: json['vote_average'].toDouble(),
      airDate: json['air_date'] ?? '',
      runtime: json['runtime'] ?? 0,
    );
  }
}
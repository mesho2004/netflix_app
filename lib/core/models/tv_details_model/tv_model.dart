class Tv {
  String title;
  String originalTitle;
  String backdropPath;
  String overview;
  double voteAverage;
  String posterPath;
  String releaseDate;
  int id;

  Tv(
      {required this.title,
      required this.originalTitle,
      required this.overview,
      required this.backdropPath,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.id});

  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
        title: json["title"] ?? '',
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        backdropPath: json["backdrop_path"] ?? '',
        posterPath: json["poster_path"] ?? '',
        releaseDate: json["release_date"] ?? '',
        id: json["id"] ?? '',
        voteAverage: json["vote_average"]);
  }
  String get fullImageUrl => 'https://image.tmdb.org/t/p/w500$posterPath';
}

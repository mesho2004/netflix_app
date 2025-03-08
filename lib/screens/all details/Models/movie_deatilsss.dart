import 'package:netflix_app/screens/all%20details/Models/cast.dart';

class MovieDetailsss {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final List<String> genres;
  final String releaseDate;
  final double voteAverage;
  final List<Casting> cast;
  final String? trailerKey;

  MovieDetailsss({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.genres,
    required this.releaseDate,
    required this.voteAverage,
    required this.cast,
    this.trailerKey,
  });

  factory MovieDetailsss.fromJson(Map<String, dynamic> json) {
    List<Casting> castList = [];
    if (json['credits'] != null && json['credits']['cast'] != null) {
      castList = (json['credits']['cast'] as List)
          .take(5)
          .map((cast) => Casting.fromJson(cast))
          .toList();
    }

    String? trailerKey;
    if (json['videos'] != null && json['videos']['results'] != null) {
      final videos = json['videos']['results'] as List;
      final trailer = videos.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );
      trailerKey = trailer?['key'];
    }

    return MovieDetailsss(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      genres: (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList(),
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
      cast: castList,
      trailerKey: trailerKey,
    );
  }
}
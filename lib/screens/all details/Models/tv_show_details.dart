import 'package:netflix_app/screens/all%20details/Models/cast.dart';
import 'package:netflix_app/screens/all%20details/Models/season.dart';

class TVShowDetails {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final List<String> genres;
  final String firstAirDate;
  final double voteAverage;
  final List<Season> seasons;
  final List<Casting> castt;
  final String? trailerKey;

  TVShowDetails({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.genres,
    required this.firstAirDate,
    required this.voteAverage,
    required this.seasons,
    required this.castt,
    this.trailerKey,
  });

  factory TVShowDetails.fromJson(Map<String, dynamic> json) {
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

    return TVShowDetails(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      genres: (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList(),
      firstAirDate: json['first_air_date'],
      voteAverage: json['vote_average'].toDouble(),
      seasons: (json['seasons'] as List)
          .map((season) => Season.fromJson(season))
          .toList(),
      castt: castList,
      trailerKey: trailerKey,
    );
  }
}
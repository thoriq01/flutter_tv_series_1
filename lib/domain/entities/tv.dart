import 'package:dicoding_tv_series/domain/entities/genre.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv(
      {required this.backdropPath,
      required this.firstAirDate,
      required this.genres,
      required this.id,
      required this.name,
      required this.originCountry,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});
  tvToMovieDetail() {
    return MovieDetail(
        adult: true,
        backdropPath: backdropPath,
        genres: [],
        id: this.id!,
        originalTitle: this.originalName!,
        overview: this.overview!,
        posterPath: this.posterPath!,
        releaseDate: this.firstAirDate!,
        runtime: 0,
        title: this.originalName!,
        voteAverage: this.voteAverage!,
        voteCount: this.voteCount!);
  }

  tvToMovie() {
    return Movie(
      adult: true,
      backdropPath: backdropPath,
      genreIds: [],
      genre: [
        Genre(id: 10, name: "Action"),
        Genre(id: 12, name: "Movie"),
      ],
      id: this.id!,
      originalTitle: this.originalName!,
      overview: this.overview!,
      popularity: 60.441,
      posterPath: this.posterPath!,
      releaseDate: this.firstAirDate!,
      title: this.originalName!,
      video: false,
      voteAverage: this.voteAverage!,
      voteCount: this.voteCount!,
    );
  }

  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genres;
  final int? id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [];
}

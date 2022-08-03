import 'package:dicoding_tv_series/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  MovieDetail(
      {this.adult,
      this.backdropPath,
      this.genres,
      this.id,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.runtime,
      this.title,
      this.voteAverage,
      this.voteCount,
      this.tipe});

  final bool? adult;
  final String? backdropPath;
  final List<Genre>? genres;
  final int? id;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final int? runtime;
  final String? title;
  final double? voteAverage;
  final int? voteCount;
  final int? tipe;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        voteAverage,
        voteCount,
      ];
}

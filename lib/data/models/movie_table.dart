import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int? tipe;
  MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    this.tipe,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id!,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        tipe: movie.tipe,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        tipe: map['tipe'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'tipe': tipe,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        tipe: tipe,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}

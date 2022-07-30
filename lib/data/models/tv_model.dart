import 'package:dicoding_tv_series/domain/entities/genre.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel(
      {this.backdropPath,
      this.firstAirDate,
      this.genreIds,
      this.id,
      this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.voteAverage,
      this.voteCount});

  final String? backdropPath;
  final String? firstAirDate;
  final List<int>? genreIds;
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
  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'],
      genreIds: json["genre_ids"] != null ? List<int>.from(json['genre_ids'].map((x) => x)) : null,
      id: json['id'],
      name: json['name'],
      originCountry: List<String>.from(json['origin_country'].map((x) => x)),
      originalLanguage: (json['original_language']),
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count']);

  Tv toEntity() {
    return Tv(
      backdropPath: this.backdropPath,
      firstAirDate: this.firstAirDate,
      genres: this.genreIds,
      originCountry: this.originCountry,
      id: this.id,
      name: this.name,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['first_air_date'] = this.firstAirDate;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }

  @override
  List<Object?> get props => [];
}

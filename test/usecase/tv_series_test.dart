import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/data/models/tv_model.dart';
import 'package:dicoding_tv_series/data/models/tv_response.dart';
import 'package:dicoding_tv_series/domain/entities/genre.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';
import '../json_reader.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late TvSeries tvSeries;
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    tvSeries = TvSeries(mockMovieRepository);
  });
  final message = "Error";
  test("Should get list tv now playing", () async {
    final list = <Tv>[testTvSeries];
    when(mockMovieRepository.getNowPlayingTv()).thenAnswer((_) async => Right(list));

    final result = await tvSeries.getNowPlayingTv();

    expect(result, Right(list));
  });
  test("Should return server failure", () async {
    when(mockMovieRepository.getNowPlayingTv()).thenAnswer((_) async => Left(ServerFailure(message)));

    final result = await tvSeries.getNowPlayingTv();

    expect(result, Left(ServerFailure(message)));
  });

  final testData = TvModel(
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    firstAirDate: "2021-09-03",
    genreIds: [10764],
    id: 130392,
    name: "The D Amelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The D Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 17.704,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 9.4,
    voteCount: 2750,
  );

  test("Read as json", () async {
    final data = TvResponse([testData]);
    final jsonData = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_top_rated.json')));
    expect(data, jsonData);
  });

  test("Should get to entity", () async {
    final das = testData.toEntity();
    expect(testTvSeries, das);
  });

  test("To json tv series", () async {
    final toJson = TvResponse([testData]).toJson();
    final jsonData = {
      "results": [
        {
          "backdrop_path": "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
          "first_air_date": "2021-09-03",
          "genre_ids": [10764],
          "id": 130392,
          "name": "The D Amelio Show",
          "origin_country": ["US"],
          "original_language": "en",
          "original_name": "The D Amelio Show",
          "overview":
              "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D Amelios are faced with new challenges and opportunities they could not have imagined.",
          "popularity": 17.704,
          "poster_path": "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
          "vote_average": 9.4,
          "vote_count": 2750
        }
      ]
    };
    expect(toJson, jsonData);
  });

  test("Tv to MovieDetail Entity", () {
    var data = testData.toEntity();
    final movieDetail = MovieDetail(
      backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
      releaseDate: "2021-09-03",
      genres: [],
      id: 130392,
      originalTitle: "The D Amelio Show",
      overview:
          "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D Amelios are faced with new challenges and opportunities they could not have imagined.",
      posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
      voteAverage: 9.4,
      voteCount: 2750,
      adult: true,
      runtime: 0,
      title: "The D Amelio Show",
    );
    expect(data.tvToMovieDetail(), movieDetail);
  });

  test("Tv to Movie", () {
    var data = testData.toEntity().tvToMovie();
    var movie = Movie(
      video: false,
      genre: [
        Genre(id: 10, name: "Action"),
        Genre(id: 12, name: "Movie"),
      ],
      backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
      releaseDate: "2021-09-03",
      genreIds: [],
      id: 130392,
      title: "The D Amelio Show",
      originalTitle: "The D Amelio Show",
      overview:
          "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D Amelios are faced with new challenges and opportunities they could not have imagined.",
      popularity: 60.441,
      posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
      voteAverage: 9.4,
      voteCount: 2750,
      adult: true,
    );
    expect(data, movie);
  });
}

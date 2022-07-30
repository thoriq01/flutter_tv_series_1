import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/data/models/tv_model.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_recomendation_bloc/tv_recomendation_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository repository;
  late TvSeries tvSeries;
  late WatchListsMovie watchListsMovie;

  late TvRecomendationBloc tvRecomendationBloc;
  late TvDetailBloc tvDetailBloc;
  late MovieWathclistBloc movieWathclistBloc;
  setUp(() {
    repository = MockMovieRepository();
    watchListsMovie = WatchListsMovie(repository);
    tvSeries = TvSeries(repository);
    tvDetailBloc = TvDetailBloc(tvSeries);
    movieWathclistBloc = MovieWathclistBloc(watchListsMovie);
    tvRecomendationBloc = TvRecomendationBloc(tvSeries);
    HttpOverrides.global = null;
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
  makeShitPassed() async {
    when(tvSeries.getTvDetail(130392)).thenAnswer((_) async => Right(testData.toEntity()));
    when(tvSeries.getTvRecomendation(130392)).thenAnswer((_) async => Right([testData.toEntity()]));
    when(watchListsMovie.isAddWatchlist(130392)).thenAnswer((_) async => true);
  }

  testWidgets("renders loading", (WidgetTester tester) async {
    makeShitPassed();
    await tester.pumpWidget(
      _makeShitPassed(tvRecomendationBloc, tvDetailBloc, movieWathclistBloc, testData),
    );
    expect(find.byType(Center), findsWidgets);
  });

  testWidgets("entah", (tester) async {
    final test = Recomendationwidget(
      movie: [testData.toEntity().tvToMovie()],
      tipe: "tv",
    );

    await tester.runAsync(() async {
      final httpData = HttpClient();
      httpData.getUrl(Uri.parse(
        "https://image.tmdb.org/t/p/w500/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
      ));
    });
    await tester.pumpWidget(
      MaterialApp(
        home: test,
      ),
    );
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets("Cari Tv Watvhlist", (tester) async {
    await tester.pumpWidget(BlocProvider<MovieWathclistBloc>.value(
        value: movieWathclistBloc, child: MaterialApp(home: TvWatchList(movie: testData.toEntity().tvToMovieDetail()))));
    expect(find.byType(Text), findsWidgets);
  });
}

MultiBlocProvider _makeShitPassed(
    TvRecomendationBloc tvRecomendationBloc, TvDetailBloc tvDetailBloc, MovieWathclistBloc movieWathclistBloc, TvModel testData) {
  return MultiBlocProvider(providers: [
    BlocProvider<TvRecomendationBloc>.value(
      value: tvRecomendationBloc,
    ),
    BlocProvider<TvDetailBloc>.value(
      value: tvDetailBloc,
    ),
    BlocProvider<MovieWathclistBloc>.value(
      value: movieWathclistBloc,
    ),
  ], child: MaterialApp(home: TvDetailPage(movie: testData.toEntity().tvToMovieDetail())));
}

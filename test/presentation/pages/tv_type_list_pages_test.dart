import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/tv_type_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository _movieRepository;

  late WatchListsMovie watchListsMovie;
  late TvPopularBloc tvPopularBloc;
  late TvTopRatedBloc tvTopRatedBloc;
  late TvNowPlayingBloc tvNowPlayingBloc;
  late TvSearchBloc tvSearchBloc;
  late TvSeries _tvSeries;

  late MovieWathclistBloc _movieWathclistBloc;

  setUp(() {
    HttpOverrides.global = null;

    _movieRepository = MockMovieRepository();

    watchListsMovie = WatchListsMovie(_movieRepository);
    _tvSeries = TvSeries(_movieRepository);
    tvSearchBloc = TvSearchBloc(_tvSeries);
    tvPopularBloc = TvPopularBloc(_tvSeries);
    tvTopRatedBloc = TvTopRatedBloc(_tvSeries);
    tvNowPlayingBloc = TvNowPlayingBloc(_tvSeries);
    _movieWathclistBloc = MovieWathclistBloc(watchListsMovie);
  });
  _makeShitPassed() {
    when(_tvSeries.getNowPlayingTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.getPopularTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.getTopRatedTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.searchTv("bold")).thenAnswer((realInvocation) async => Right([testTvSeries]));
  }

  _makePass(String tipe) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSearchBloc>.value(value: tvSearchBloc),
        BlocProvider<TvTopRatedBloc>.value(value: tvTopRatedBloc),
        BlocProvider<TvPopularBloc>.value(value: tvPopularBloc),
        BlocProvider<TvNowPlayingBloc>.value(value: tvNowPlayingBloc),
      ],
      child: MaterialApp(
        home: TvTypeListPage(category: tipe),
      ),
    );
  }

  testWidgets("Test widget", (tester) async {
    _makeShitPassed();
    await tester.pumpWidget(_makePass("tvpopular"));
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Text), findsWidgets);
  });
  testWidgets("Test widget", (tester) async {
    _makeShitPassed();
    await tester.pumpWidget(_makePass("tvtoprated"));
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Text), findsWidgets);
  });
  testWidgets("Test widget", (tester) async {
    _makeShitPassed();
    await tester.pumpWidget(_makePass("tvnowplaying"));
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Text), findsWidgets);
  });
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/get_now_playing_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/get_top_rated_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sizer/sizer.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockMovieRepository _movieRepository;
  late GetPopularMovie getPopularMoviesBloc;
  late GetTopRatedMovie getTopRatedMoviesBloc;
  late GetNowPlaying getNowPlayingMoviesBloc;
  late WatchListsMovie watchListsMovie;
  late SearchMovie searchMovie;
  late TvPopularBloc tvPopularBloc;
  late TvTopRatedBloc tvTopRatedBloc;
  late TvNowPlayingBloc tvNowPlayingBloc;
  late TvSearchBloc tvSearchBloc;
  late TvSeries _tvSeries;
  late MoviePopularBlocBloc _moviePopularBloc;
  late MovieNowPlayingBloc _movieNowPlayingBloc;
  late MovieTopRatedBloc _movieTopRatedBloc;
  late MovieSearchBloc _movieSearchBloc;
  late MovieWathclistBloc _movieWathclistBloc;

  setUp(() {
    HttpOverrides.global = null;

    _movieRepository = MockMovieRepository();
    getPopularMoviesBloc = GetPopularMovie(_movieRepository);
    getTopRatedMoviesBloc = GetTopRatedMovie(_movieRepository);
    getNowPlayingMoviesBloc = GetNowPlaying(_movieRepository);
    watchListsMovie = WatchListsMovie(_movieRepository);
    searchMovie = SearchMovie(_movieRepository);
    _tvSeries = TvSeries(_movieRepository);
    tvSearchBloc = TvSearchBloc(_tvSeries);
    tvPopularBloc = TvPopularBloc(_tvSeries);
    tvTopRatedBloc = TvTopRatedBloc(_tvSeries);
    tvNowPlayingBloc = TvNowPlayingBloc(_tvSeries);
    _moviePopularBloc = MoviePopularBlocBloc(getPopularMoviesBloc);
    _movieNowPlayingBloc = MovieNowPlayingBloc(getNowPlayingMoviesBloc);
    _movieTopRatedBloc = MovieTopRatedBloc(getTopRatedMoviesBloc);
    _movieSearchBloc = MovieSearchBloc(searchMovie);
    _movieWathclistBloc = MovieWathclistBloc(watchListsMovie);
  });

  testWidgets('Test', (tester) async {
    when(getNowPlayingMoviesBloc.execute()).thenAnswer((_) async => Right(testMovieList));
    when(getTopRatedMoviesBloc.execute()).thenAnswer((_) async => Right(testMovieList));
    when(getPopularMoviesBloc.execute()).thenAnswer((_) async => Right(testMovieList));
    when(_tvSeries.getNowPlayingTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.getPopularTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.getTopRatedTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.searchTv("bold")).thenAnswer((_) async => Right([testTvSeries]));

    when(watchListsMovie.getData()).thenAnswer((_) async => Right(testMovieList));
    await tester.pumpWidget(MultiBlocProvider(providers: [
      BlocProvider<MoviePopularBlocBloc>.value(value: _moviePopularBloc),
      BlocProvider<MovieTopRatedBloc>.value(value: _movieTopRatedBloc),
      BlocProvider<MovieNowPlayingBloc>.value(value: _movieNowPlayingBloc),
      BlocProvider<MovieWathclistBloc>.value(value: _movieWathclistBloc),
      BlocProvider<MovieSearchBloc>.value(value: _movieSearchBloc),
      BlocProvider<TvTopRatedBloc>.value(value: tvTopRatedBloc),
      BlocProvider<TvPopularBloc>.value(value: tvPopularBloc),
      BlocProvider<TvNowPlayingBloc>.value(value: tvNowPlayingBloc),
      BlocProvider<TvSearchBloc>.value(value: tvSearchBloc),
    ], child: MaterialApp(home: MovieListPage())));
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets("Test widget", (tester) async {
    when(_tvSeries.getNowPlayingTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.getPopularTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.getTopRatedTv()).thenAnswer((_) async => Right([testTvSeries]));
    when(_tvSeries.searchTv("bold")).thenAnswer((realInvocation) async => Right([testTvSeries]));
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<TvSearchBloc>.value(value: tvSearchBloc),
          BlocProvider<TvTopRatedBloc>.value(value: tvTopRatedBloc),
          BlocProvider<TvPopularBloc>.value(value: tvPopularBloc),
          BlocProvider<TvNowPlayingBloc>.value(value: tvNowPlayingBloc),
        ],
        child: Sizer(
          builder: ((context, orientation, deviceType) => MaterialApp(
                home: TvWidget(),
              )),
        ),
      ),
    );
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets("Test aja lah", (tester) async {
    final widget = MovieListCard(
        length: testMovieList.length, direction: Axis.horizontal, movies: testMovieList, height: 300, isWatchlist: false, tipe: "movie");
    await tester.pumpWidget(MaterialApp(
      home: widget,
    ));
    expect(find.byType(Container), findsWidgets);
  });
}

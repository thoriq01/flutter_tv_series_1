import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late TvSeries tvSeries;
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    tvSeries = TvSeries(mockMovieRepository);
  });

  test("Should emit MovieNowPlayigLoaded", () async* {
    when(tvSeries.getNowPlayingTv()).thenAnswer((_) async => Right([testTvSeries]));
    final bloc = TvNowPlayingBloc(tvSeries)..add(LoadTvNowPlaying());
    expect(
      bloc,
      emitsInOrder([
        TvNowPlayingInitial(),
        TvNowPlayingLoading(),
        TvNowPlayingLoaded([testTvSeries])
      ]),
    );
  });

  test("Should emit MovieNowPlayingError", () async* {
    when(tvSeries.getTopRatedTv()).thenAnswer((_) async => Left(ConnectionFailure("Error")));
    final bloc = TvNowPlayingBloc(tvSeries)..add(LoadTvNowPlaying());
    expect(bloc, emitsInOrder([TvTopRatedError("Error")]));
  });

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    "Test",
    setUp: () {
      when(tvSeries.getNowPlayingTv()).thenAnswer((_) async => Right([testTvSeries]));
    },
    build: () {
      return TvNowPlayingBloc(tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvNowPlaying()),
    expect: () => [
      isA<TvNowPlayingInitial>(),
      isA<TvNowPlayingLoading>(),
      isA<TvNowPlayingLoaded>(),
    ],
  );
  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    "Test",
    setUp: () {
      when(tvSeries.getNowPlayingTv()).thenAnswer((_) async => Left(ServerFailure("Error")));
    },
    build: () {
      return TvNowPlayingBloc(tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvNowPlaying()),
    expect: () => [
      isA<TvNowPlayingInitial>(),
      isA<TvNowPlayingLoading>(),
      isA<TvNowPlayingError>(),
    ],
  );
}

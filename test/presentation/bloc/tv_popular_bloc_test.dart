import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

class _MockTvSeries extends Mock implements TvSeries {}

void main() {
  late _MockTvSeries _mockTvSeries;
  late MockMovieRepository _mockMovieRepository;
  late TvSeries _tvSeries;
  setUp(() {
    _mockTvSeries = _MockTvSeries();
    _mockMovieRepository = MockMovieRepository();
    _tvSeries = TvSeries(_mockMovieRepository);
  });

  test("Should emit MovieNowPlayigLoaded", () async* {
    when(_mockTvSeries.getTopRatedTv()).thenAnswer((_) async => Right([testTvSeries]));
    final bloc = TvPopularBloc(_mockTvSeries)..add(LoadTvPopular());
    expect(
      bloc,
      emitsInOrder([
        TvTopRatedInitial(),
        TvTopRatedLoading(),
        TvTopRatedLoaded([testTvSeries])
      ]),
    );
  });

  test("Should emit MovieNowPlayingError", () async* {
    when(_mockTvSeries.getTopRatedTv()).thenAnswer((_) async => Left(ConnectionFailure("Error")));
    final bloc = TvPopularBloc(_mockTvSeries)..add(LoadTvPopular());
    expect(bloc, emitsInOrder([TvTopRatedError("Error")]));
  });
  blocTest<TvPopularBloc, TvPopularState>(
    "Test",
    build: () {
      when(_tvSeries.getPopularTv()).thenAnswer((_) async => Right([testTvSeries]));
      return TvPopularBloc(_tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvPopular()),
    expect: () => [
      isA<TvPopularInitial>(),
      isA<TvPopularLoading>(),
      isA<TvPopularLoaded>(),
    ],
  );
  blocTest<TvPopularBloc, TvPopularState>(
    "Test",
    build: () {
      when(_tvSeries.getPopularTv()).thenAnswer((_) async => Left(ServerFailure("Error")));
      return TvPopularBloc(_tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvPopular()),
    expect: () => [
      isA<TvPopularInitial>(),
      isA<TvPopularLoading>(),
      isA<TvPopularError>(),
    ],
  );
}

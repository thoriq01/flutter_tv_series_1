import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
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

  final id = 122108;
  Future makeThisShitTestPassed() async {
    when(tvSeries.getTvDetail(id)).thenAnswer((_) async => Right(testTvSeries));
  }

  Future makeThisShitTestPassed1() async {
    when(tvSeries.getTvDetail(id)).thenAnswer((_) async => Left(ServerFailure("message")));
  }

  blocTest<TvDetailBloc, TvDetailState>(
    "Should emit [TvRecomendationLoaded]",
    setUp: () async {
      await makeThisShitTestPassed();
    },
    build: () {
      return TvDetailBloc(tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvDetailEvent(id)),
    expect: () => [
      isA<TvDetailInitial>(),
      isA<TvDetailLoading>(),
      isA<TvDetailLoaded>(),
    ],
  );
  blocTest<TvDetailBloc, TvDetailState>(
    "Should emit [TvRecomendationLoaded]",
    setUp: () async {
      await makeThisShitTestPassed1();
    },
    build: () {
      return TvDetailBloc(tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvDetailEvent(id)),
    expect: () => [isA<TvDetailInitial>(), isA<TvDetailLoading>(), isA<TvDetailError>()],
  );

  test("Test", () async {
    var tv = LoadTvDetailEvent(66732);
    expect(tv.id, 66732);
  });
}

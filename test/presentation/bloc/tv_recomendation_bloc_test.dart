import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_recomendation_bloc/tv_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository repository;
  late TvSeries tvSeries;
  setUp(() {
    repository = MockMovieRepository();
    tvSeries = TvSeries(repository);
  });

  final id = 66732;

  blocTest<TvRecomendationBloc, TvRecomendationState>(
    "Should emit [TvRecomendationLoaded]",
    setUp: () {
      when(tvSeries.getTvRecomendation(id)).thenAnswer((_) async => Left(ServerFailure("message")));
    },
    build: () {
      return TvRecomendationBloc(tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvRecomendationEvent(id)),
    expect: () => [
      isA<TvRecomendationInitial>(),
      isA<TvRecomendationLoading>(),
      isA<TvRecomendationError>(),
    ],
  );
  blocTest<TvRecomendationBloc, TvRecomendationState>(
    "Should emit [TvRecomendationLoaded]",
    setUp: () {
      when(tvSeries.getTvRecomendation(id)).thenAnswer((_) async => Right([testTvSeries]));
    },
    build: () {
      return TvRecomendationBloc(tvSeries);
    },
    act: (bloc) => bloc.add(LoadTvRecomendationEvent(id)),
    expect: () => [isA<TvRecomendationInitial>(), isA<TvRecomendationLoading>(), isA<TvRecomendationLoaded>()],
  );

  test("Test", () async {
    var tv = LoadTvRecomendationEvent(66732);
    expect(tv.id, 66732);
  });
  test("Test", () async {
    var tv = LoadTvRecomendationEvent(66732);
    expect(tv.props, [66732]);
  });
}

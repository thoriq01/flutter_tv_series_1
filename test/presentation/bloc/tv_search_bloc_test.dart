import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
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
    when(_mockTvSeries.searchTv("bold")).thenAnswer((_) async => Right([testTvSeries]));
    final bloc = TvTopRatedBloc(_mockTvSeries)..add(LoadTvTopRated());
    expect(
      bloc,
      emitsInOrder([
        TvSearchInitial(),
        TvSearchLoading(),
        TvSearchLoaded([testTvSeries])
      ]),
    );
  });

  test("Should emit MovieNowPlayingError", () async* {
    when(_mockTvSeries.searchTv("bold")).thenAnswer((_) async => Left(ConnectionFailure("Error")));
    final bloc = TvTopRatedBloc(_mockTvSeries)..add(LoadTvTopRated());
    expect(bloc, emitsInOrder([TvTopRatedError("Error")]));
  });
  blocTest<TvSearchBloc, TvSearchState>(
    "Test",
    setUp: () {},
    build: () {
      when(_tvSeries.searchTv("bold")).thenAnswer((_) async => Right([testTvSeries]));
      return TvSearchBloc(_tvSeries);
    },
    act: (bloc) => bloc.add(SearchTvEvent("bold")),
    expect: () => [
      isA<TvSearchInitial>(),
      isA<TvSearchLoading>(),
      isA<TvSearchLoaded>(),
    ],
  );
  blocTest<TvSearchBloc, TvSearchState>(
    "Test",
    setUp: () {},
    build: () {
      when(_tvSeries.searchTv("bold")).thenAnswer((_) async => Left(ServerFailure("Error")));
      return TvSearchBloc(_tvSeries);
    },
    act: (bloc) => bloc.add(SearchTvEvent("bold")),
    expect: () => [
      isA<TvSearchInitial>(),
      isA<TvSearchLoading>(),
      isA<TvSearchError>(),
    ],
  );
  blocTest<TvSearchBloc, TvSearchState>(
    "Test",
    setUp: () {},
    build: () {
      when(_tvSeries.getTopRatedTv()).thenAnswer((_) async => Left(ServerFailure("Error")));
      return TvSearchBloc(_tvSeries);
    },
    act: (bloc) => bloc.add(RemoveSearchTvEvent()),
    expect: () => [
      isA<TvSearchEmpty>(),
    ],
  );

  test("Test", () async {
    final data = SearchTvEvent("bold");
    expect(data.query, "bold");
    expect(data.props, ["bold"]);
  });
  test("test", () {
    final data = RemoveSearchTvEvent();
    expect(data.props, []);
  });
}

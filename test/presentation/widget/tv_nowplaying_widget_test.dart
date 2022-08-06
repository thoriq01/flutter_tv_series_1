import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/widget/tv_now_playing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import 'tv_nowplaying_widget_test.mocks.dart';

@GenerateMocks([TvNowPlayingBloc, TvTopRatedBloc, TvPopularBloc])
void main() {
  late TvSeries tvSeries;
  late MockMovieRepository movieRepository;
  late TvNowPlayingBloc tvNowPlayingBloc;
  late MockTvNowPlayingBloc mockTvNowPlayingBloc;
  setUp(() {
    movieRepository = MockMovieRepository();
    tvSeries = TvSeries(movieRepository);
    tvNowPlayingBloc = TvNowPlayingBloc(tvSeries);
    mockTvNowPlayingBloc = MockTvNowPlayingBloc();
  });
  _makeTestableWidget(Widget body) {
    return (BlocProvider<TvNowPlayingBloc>.value(value: tvNowPlayingBloc, child: MaterialApp(home: body)));
  }

  testWidgets("Test ", (tester) async {
    when(tvSeries.getNowPlayingTv()).thenAnswer((realInvocation) async => Right([testTvSeries]));
    await tester.pumpWidget(_makeTestableWidget(TvNowPlayingWidget()));
    expect(find.byType(Center), findsOneWidget);
  });
  testWidgets("Test ", (tester) async {
    when(tvSeries.getNowPlayingTv()).thenAnswer((realInvocation) async => Right([testTvSeries]));
    when(mockTvNowPlayingBloc.state).thenReturn(TvNowPlayingError("Erro"));
    await tester.pumpWidget(_makeTestableWidget(TvNowPlayingWidget()));
    expect(find.byType(Center), findsOneWidget);
  });
}

import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/widget/title_content.dart';
import 'package:dicoding_tv_series/presentation/widget/tv_popular_widget.dart';
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
  late TvPopularBloc tvPopularBloc;
  late MockTvPopularBloc mockTvPopularBloc;
  setUp(() {
    movieRepository = MockMovieRepository();
    tvSeries = TvSeries(movieRepository);
    tvPopularBloc = TvPopularBloc(tvSeries);
    mockTvPopularBloc = MockTvPopularBloc();
  });
  _makeTestableWidget(Widget body) {
    return (BlocProvider<TvPopularBloc>.value(value: tvPopularBloc, child: MaterialApp(home: body)));
  }

  testWidgets("Test ", (tester) async {
    when(tvSeries.getPopularTv()).thenAnswer((realInvocation) async => Right([testTvSeries]));
    await tester.pumpWidget(_makeTestableWidget(TvPopularWidget()));
    expect(find.byType(Center), findsOneWidget);
  });
  testWidgets("Test ", (tester) async {
    when(tvSeries.getPopularTv()).thenAnswer((realInvocation) async => Right([testTvSeries]));
    when(mockTvPopularBloc.state).thenReturn(TvPopularError("Erro"));
    await tester.pumpWidget(_makeTestableWidget(TvPopularWidget()));
    expect(find.byType(TvPopularWidget), findsOneWidget);
  });

  testWidgets("Test", (tester) async {
    final test = TitleContent(text: "Null", onPressed: () {});
    await tester.pumpWidget(
      MaterialApp(
        home: test,
      ),
    );
    expect(find.byType(Row), findsWidgets);
  });
}

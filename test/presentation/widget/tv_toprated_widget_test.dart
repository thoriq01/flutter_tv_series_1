import 'package:bloc_test/bloc_test.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/widget/tv_top_rated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

class MockTopRatedBloc extends MockBloc<TvTopRatedEvent, TvTopRatedState> implements TvTopRatedBloc {}

void main() {
  late TvSeries tvSeries;
  late MockMovieRepository movieRepository;
  late MockTopRatedBloc tvTopRatedBloc;
  setUp(() {
    movieRepository = MockMovieRepository();
    tvSeries = TvSeries(movieRepository);
    tvTopRatedBloc = MockTopRatedBloc();
    tvTopRatedBloc.add(LoadTvTopRated());
  });
  _makeTestableWidget(Widget body) {
    return (BlocProvider<TvTopRatedBloc>.value(value: TvTopRatedBloc(tvSeries), child: MaterialApp(home: body)));
  }

  _makethiShitPassed() {
    whenListen<TvTopRatedState>(
      tvTopRatedBloc,
      Stream.fromIterable(
        [
          TvTopRatedLoading(),
          TvTopRatedLoaded([testTvSeries]),
          TvTopRatedError("Message"),
        ],
      ),
      initialState: TvTopRatedLoaded([testTvSeries]),
    );
  }

  // });
  testWidgets("Test ", (tester) async {
    _makethiShitPassed();
    await tester.pumpWidget(_makeTestableWidget(TvTopRatedWidget()));
    expect(find.byType(Container), findsOneWidget);
  });
}

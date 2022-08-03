import 'dart:io';

import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_detail.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets("test movie card 1", (tester) async {
    final test = MovieCard(
      title: "Mejiku",
      posterPath: "https://image.tmdb.org/t/p/w500/poster_path",
      tipe: 1,
      date: "2022-12-12",
      overview: "Mejiku is a story of two people who must fight to save their lives.",
      isWatchlist: false,
    );

    await tester.runAsync(() async {
      final httpData = HttpClient();
      final request = httpData.getUrl(Uri.parse("https://image.tmdb.org/t/p/w500/poster_path"));
    });
    await tester.pumpWidget(
      MaterialApp(
        home: test,
      ),
    );
    expect(find.byType(Container), findsWidgets);
  });
  testWidgets("test movie card 2", (tester) async {
    final test = MovieCard(
      title: "Mejiku",
      posterPath: "https://image.tmdb.org/t/p/w500/poster_path",
      date: "2022-12-12",
      overview: "Mejiku is a story of two people who must fight to save their lives.",
      isWatchlist: true,
    );

    await tester.runAsync(() async {
      final httpData = HttpClient();
      final request = httpData.getUrl(Uri.parse("https://image.tmdb.org/t/p/w500/poster_path"));
    });
    await tester.pumpWidget(
      MaterialApp(
        home: test,
      ),
    );
    expect(find.byType(Container), findsWidgets);
  });
  testWidgets("Test", (tester) async {
    await tester.pumpWidget(MaterialApp(home: RecomendationWidget(movies: testMovieList, tipe: "movies")));
    expect(find.byType(Text), findsWidgets);
  });
  testWidgets("Test", (tester) async {
    final dataCast = MovieCastEntities(false, 1, 1200, "", "Agus", "Alfaro Agus", 10293, "https://image.tmdb.org/t/p/w500/poster_path");
    await tester.pumpWidget(MaterialApp(
        home: CastWidget(
      cast: [dataCast],
    )));
    expect(find.byType(Text), findsWidgets);
  });
}

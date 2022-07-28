import 'dart:convert';

import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/data/models/movie_detail_model.dart';
import 'package:dicoding_tv_series/data/models/movie_response.dart';
import 'package:dicoding_tv_series/data/models/tv_response.dart';
import 'package:dicoding_tv_series/data/source/online/movie_online_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../helpers/test_helper.mocks.dart';
import '../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieDataSource(client: mockHttpClient);
  });

  group('get Popular Movies', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json'))).movieList;

    test('should return list of movies when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/popular.json'), 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/top_rated.json'))).movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/movie_detail.json'), 200));
      // act
      final result = await dataSource.getDetailMovies(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getDetailMovies(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(json.decode(readJson('dummy_data/search_movie.json'))).movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/search_movie.json'), 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('now playing movies', () {
    final tSearchResult = MovieResponse.fromJson(json.decode(readJson('dummy_data/now_playing.json'))).movieList;

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse("$BASE_URL/movie/now_playing?$API_KEY")))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, tSearchResult);
    });
  });

  // get movie cast
  group('get movie cast', () {
    final tCastList = MovieCastResponse.fromJson(json.decode(readJson('dummy_data/movie_cast.json'))).movieCast;
    final tId = 438148;

    test('should return list of cast when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId/credits?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/movie_cast.json'), 200));
      // act
      final result = await dataSource.getMovieCast(tId);
      // assert
      expect(result, tCastList);
    });
    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId/credits?$API_KEY'))).thenAnswer((_) async => http.Response("Not Found", 400)); // act
      final call = dataSource.getMovieCast(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('get movie recomendations', () {
    final tCastList = MovieResponse.fromJson(json.decode(readJson('dummy_data/movie_recomendations.json'))).movieList;
    final tId = 507086;

    test('should return list of cast when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/movie_recomendations.json'), 200));
      // act
      final result = await dataSource.getRecomendationsMovies(tId);
      // assert
      expect(result, tCastList);
    });
    // test('should throw ServerException when response code is other than 200', () async {
    //   // arrange
    //   when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
    //       .thenAnswer((_) async => http.Response("Not Foynd", 400)); // act
    //   final call = dataSource.getRecomendationsMovies(tId);
    //   // assert
    //   expect(() => call, throwsA(isA<ServerException>()));
    // });
  });

  group("Tv Now Playing", () {
    final tSearchResult = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_now_playing.json'))).tvList;

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse("https://api.themoviedb.org/3/tv/on_the_air?$API_KEY")))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_now_playing.json'), 200));
      // act
      final result = await dataSource.getNowPlayingTv();
      // assert
      expect(result, tSearchResult);
    });
    // test('should return error of movies when response code more than 200', () async {
    //   // arrange
    //   when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/on_the_air?$API_KEY"))).thenThrow((_) async => http.Response("Error", 404));
    //   // act
    //   final result = await dataSource.getNowPlayingTv();
    //   // assert
    //   expect(result, throwsA(isA<ServerException>()));
    // });
  });
  group("Tv Popular", () {
    final tSearchResult = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json'))).tvList;

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY")))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, tSearchResult);
    });
    // test('should return error of movies when response code more than 200', () async {
    //   // arrange
    //   when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/popular?$API_KEY"))).thenThrow((_) async => http.Response("Error", 404));
    //   // act
    //   final result = await dataSource.getPopularTv();
    //   // assert
    //   expect(result, throwsA(isA<ServerException>()));
    // });
  });
  group("Tv Top Rated", () {
    test('should return list of movies when response code is 200', () async {
      final tSearchResult = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_top_rated.json'))).tvList;

      // arrange
      when(mockHttpClient.get(Uri.parse("https://api.themoviedb.org/3/tv/top_rated?$API_KEY")))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, tSearchResult);
    });
  });
  test('should return error of movies when response code more than 200', () async {
    // arrange
    when(mockHttpClient.get(Uri.parse("$BASE_URL/tv/top_rated?$API_KEY"))).thenThrow((_) async => http.Response("Error", 404));
    // act
    final result = await dataSource.getTopRatedTv();
    // assert
    expect(result, throwsA(isA<ServerException>()));
  });
}

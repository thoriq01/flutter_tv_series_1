// Mocks generated by Mockito 5.0.15 from annotations
// in dicoding_tv_series/test/presentation/widget/movie_populart_widget_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i5;
import 'package:dicoding_tv_series/domain/usecase/get_popular_movie.dart'
    as _i2;
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetPopularMovie_0 extends _i1.Fake implements _i2.GetPopularMovie {}

class _FakeMoviePopularBlocState_1 extends _i1.Fake
    implements _i3.MoviePopularBlocState {}

/// A class which mocks [MoviePopularBlocBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviePopularBlocBloc extends _i1.Mock
    implements _i3.MoviePopularBlocBloc {
  MockMoviePopularBlocBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetPopularMovie get getPopularMovie =>
      (super.noSuchMethod(Invocation.getter(#getPopularMovie),
          returnValue: _FakeGetPopularMovie_0()) as _i2.GetPopularMovie);
  @override
  _i3.MoviePopularBlocState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
              returnValue: _FakeMoviePopularBlocState_1())
          as _i3.MoviePopularBlocState);
  @override
  _i4.Stream<_i3.MoviePopularBlocState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.MoviePopularBlocState>.empty())
          as _i4.Stream<_i3.MoviePopularBlocState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.MoviePopularBlocEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.MoviePopularBlocEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.MoviePopularBlocState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.MoviePopularBlocEvent>(
          _i5.EventHandler<E, _i3.MoviePopularBlocState>? handler,
          {_i5.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i5.Transition<_i3.MoviePopularBlocEvent, _i3.MoviePopularBlocState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  void onChange(_i5.Change<_i3.MoviePopularBlocState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}

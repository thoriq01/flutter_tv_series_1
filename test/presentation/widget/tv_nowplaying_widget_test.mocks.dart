// Mocks generated by Mockito 5.0.15 from annotations
// in dicoding_tv_series/test/presentation/widget/tv_nowplaying_widget_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:bloc/bloc.dart' as _i7;
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart' as _i2;
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart'
    as _i3;
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart'
    as _i5;
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTvSeries_0 extends _i1.Fake implements _i2.TvSeries {}

class _FakeTvNowPlayingState_1 extends _i1.Fake
    implements _i3.TvNowPlayingState {}

class _FakeTvTopRatedState_2 extends _i1.Fake implements _i4.TvTopRatedState {}

class _FakeTvPopularState_3 extends _i1.Fake implements _i5.TvPopularState {}

/// A class which mocks [TvNowPlayingBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvNowPlayingBloc extends _i1.Mock implements _i3.TvNowPlayingBloc {
  MockTvNowPlayingBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeries get tvSeries => (super.noSuchMethod(Invocation.getter(#tvSeries),
      returnValue: _FakeTvSeries_0()) as _i2.TvSeries);
  @override
  _i3.TvNowPlayingState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeTvNowPlayingState_1()) as _i3.TvNowPlayingState);
  @override
  _i6.Stream<_i3.TvNowPlayingState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i3.TvNowPlayingState>.empty())
          as _i6.Stream<_i3.TvNowPlayingState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i3.TvNowPlayingEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i3.TvNowPlayingEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i3.TvNowPlayingState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i3.TvNowPlayingEvent>(
          _i7.EventHandler<E, _i3.TvNowPlayingState>? handler,
          {_i7.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i7.Transition<_i3.TvNowPlayingEvent, _i3.TvNowPlayingState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void onChange(_i7.Change<_i3.TvNowPlayingState>? change) =>
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

/// A class which mocks [TvTopRatedBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvTopRatedBloc extends _i1.Mock implements _i4.TvTopRatedBloc {
  MockTvTopRatedBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeries get tvSeries => (super.noSuchMethod(Invocation.getter(#tvSeries),
      returnValue: _FakeTvSeries_0()) as _i2.TvSeries);
  @override
  _i4.TvTopRatedState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeTvTopRatedState_2()) as _i4.TvTopRatedState);
  @override
  _i6.Stream<_i4.TvTopRatedState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i4.TvTopRatedState>.empty())
          as _i6.Stream<_i4.TvTopRatedState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i4.TvTopRatedEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i4.TvTopRatedEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i4.TvTopRatedState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i4.TvTopRatedEvent>(
          _i7.EventHandler<E, _i4.TvTopRatedState>? handler,
          {_i7.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i7.Transition<_i4.TvTopRatedEvent, _i4.TvTopRatedState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void onChange(_i7.Change<_i4.TvTopRatedState>? change) =>
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

/// A class which mocks [TvPopularBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvPopularBloc extends _i1.Mock implements _i5.TvPopularBloc {
  MockTvPopularBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeries get tvSeries => (super.noSuchMethod(Invocation.getter(#tvSeries),
      returnValue: _FakeTvSeries_0()) as _i2.TvSeries);
  @override
  _i5.TvPopularState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeTvPopularState_3()) as _i5.TvPopularState);
  @override
  _i6.Stream<_i5.TvPopularState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i5.TvPopularState>.empty())
          as _i6.Stream<_i5.TvPopularState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i5.TvPopularEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.TvPopularEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i5.TvPopularState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i5.TvPopularEvent>(
          _i7.EventHandler<E, _i5.TvPopularState>? handler,
          {_i7.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i7.Transition<_i5.TvPopularEvent, _i5.TvPopularState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void onChange(_i7.Change<_i5.TvPopularState>? change) =>
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
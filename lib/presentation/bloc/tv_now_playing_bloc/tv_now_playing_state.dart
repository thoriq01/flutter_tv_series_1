part of 'tv_now_playing_bloc.dart';

abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();

  @override
  List<Object> get props => [];
}

class TvNowPlayingInitial extends TvNowPlayingState {}

class TvNowPlayingLoading extends TvNowPlayingState {}

class TvNowPlayingLoaded extends TvNowPlayingState {
  final List<Tv> tvList;

  TvNowPlayingLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class TvNowPlayingError extends TvNowPlayingState {
  final String message;

  TvNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

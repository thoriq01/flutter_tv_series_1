part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();

  @override
  List<Object> get props => [];
}

class TvPopularInitial extends TvPopularState {}

class TvPopularLoading extends TvPopularState {}

class TvPopularLoaded extends TvPopularState {
  final List<Tv> tvList;

  TvPopularLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class TvPopularError extends TvPopularState {
  final String message;

  TvPopularError(this.message);

  @override
  List<Object> get props => [message];
}

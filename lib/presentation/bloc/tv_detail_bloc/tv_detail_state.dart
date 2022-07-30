part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final Tv tvDetail;

  TvDetailLoaded(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class TvDetailError extends TvDetailState {
  final String error;

  TvDetailError(this.error);

  @override
  List<Object> get props => [error];
}

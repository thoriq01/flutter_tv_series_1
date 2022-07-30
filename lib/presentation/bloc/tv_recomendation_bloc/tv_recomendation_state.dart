part of 'tv_recomendation_bloc.dart';

abstract class TvRecomendationState extends Equatable {
  const TvRecomendationState();

  @override
  List<Object> get props => [];
}

class TvRecomendationInitial extends TvRecomendationState {}

class TvRecomendationLoading extends TvRecomendationState {}

class TvRecomendationLoaded extends TvRecomendationState {
  final List<Tv> tvRecomendation;

  TvRecomendationLoaded(this.tvRecomendation);

  @override
  List<Object> get props => [tvRecomendation];
}

class TvRecomendationError extends TvRecomendationState {
  final String error;

  TvRecomendationError(this.error);

  @override
  List<Object> get props => [error];
}

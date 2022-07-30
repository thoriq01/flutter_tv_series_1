part of 'tv_recomendation_bloc.dart';

abstract class TvRecomendationEvent extends Equatable {
  const TvRecomendationEvent();

  @override
  List<Object> get props => [];
}

class LoadTvRecomendationEvent extends TvRecomendationEvent {
  final int id;

  LoadTvRecomendationEvent(this.id);

  @override
  List<Object> get props => [id];
}

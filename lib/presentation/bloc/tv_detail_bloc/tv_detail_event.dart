part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadTvDetailEvent extends TvDetailEvent {
  final int id;

  LoadTvDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}

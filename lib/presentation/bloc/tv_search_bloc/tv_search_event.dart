part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTvEvent extends TvSearchEvent {
  final String query;

  SearchTvEvent(this.query);

  @override
  List<Object> get props => [query];
}

class RemoveSearchTvEvent extends TvSearchEvent {}

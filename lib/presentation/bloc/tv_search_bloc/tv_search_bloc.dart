import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final TvSeries tvSeries;
  TvSearchBloc(this.tvSeries) : super(TvSearchInitial()) {
    on<SearchTvEvent>(_searchTv);
    on<RemoveSearchTvEvent>(_removeSearchTv);
  }

  _searchTv(SearchTvEvent event, Emitter<TvSearchState> emit) async {
    emit(TvSearchInitial());
    emit(TvSearchLoading());
    final response = await tvSeries.searchTv(event.query);
    response.fold((l) => emit(TvSearchError(l.message)), (r) => emit(TvSearchLoaded(r)));
  }

  _removeSearchTv(RemoveSearchTvEvent event, Emitter<TvSearchState> emit) async {
    emit(TvSearchEmpty());
  }
}

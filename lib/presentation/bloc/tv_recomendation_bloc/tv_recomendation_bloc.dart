import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_recomendation_event.dart';
part 'tv_recomendation_state.dart';

class TvRecomendationBloc extends Bloc<TvRecomendationEvent, TvRecomendationState> {
  final TvSeries tvSeries;
  TvRecomendationBloc(this.tvSeries) : super(TvRecomendationInitial()) {
    on<LoadTvRecomendationEvent>(_loadRecomendation);
  }
  _loadRecomendation(LoadTvRecomendationEvent event, Emitter<TvRecomendationState> emit) async {
    emit(TvRecomendationInitial());
    emit(TvRecomendationLoading());
    final result = await tvSeries.getTvRecomendation(event.id);
    result.fold((l) => emit(TvRecomendationError(l.message)), (r) => emit(TvRecomendationLoaded(r)));
  }
}

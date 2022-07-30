import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final TvSeries tvSeries;
  TvDetailBloc(this.tvSeries) : super(TvDetailInitial()) {
    on<LoadTvDetailEvent>(_loadTvDetail);
  }

  _loadTvDetail(LoadTvDetailEvent event, Emitter<TvDetailState> emit) async {
    emit(TvDetailInitial());
    emit(TvDetailLoading());
    final result = await tvSeries.getTvDetail(event.id);
    result.fold((l) => emit(TvDetailError(l.message)), (r) => emit(TvDetailLoaded(r)));
  }
}

import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final TvSeries tvSeries;
  TvTopRatedBloc(this.tvSeries) : super(TvTopRatedInitial()) {
    on<LoadTvTopRated>(_loadTvtopRated);
  }

  _loadTvtopRated(LoadTvTopRated event, Emitter<TvTopRatedState> emit) async {
    emit(TvTopRatedInitial());
    emit(TvTopRatedLoading());
    final tvList = await tvSeries.getTopRatedTv();
    tvList.fold((l) => emit(TvTopRatedError(l.message)), (r) => emit(TvTopRatedLoaded(r)));
  }
}

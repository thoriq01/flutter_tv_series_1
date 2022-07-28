import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final TvSeries tvSeries;
  TvPopularBloc(this.tvSeries) : super(TvPopularInitial()) {
    on<LoadTvPopular>(_loadTvPopular);
  }

  _loadTvPopular(LoadTvPopular event, Emitter<TvPopularState> emit) async {
    emit(TvPopularInitial());
    emit(TvPopularLoading());
    final tvList = await tvSeries.getPopularTv();
    tvList.fold((l) => emit(TvPopularError(l.message)), (r) => emit(TvPopularLoaded(r)));
  }
}

import 'package:bloc/bloc.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/usecase/tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final TvSeries tvSeries;
  TvNowPlayingBloc(this.tvSeries) : super(TvNowPlayingInitial()) {
    on<LoadTvNowPlaying>(_loadTvNowPlaying);
  }

  _loadTvNowPlaying(LoadTvNowPlaying event, Emitter<TvNowPlayingState> emit) async {
    emit(TvNowPlayingInitial());
    emit(TvNowPlayingLoading());
    final tvList = await tvSeries.getNowPlayingTv();
    tvList.fold((l) => emit(TvNowPlayingError(l.message)), (r) => emit(TvNowPlayingLoaded(r)));
  }
}

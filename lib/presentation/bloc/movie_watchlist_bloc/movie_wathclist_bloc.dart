import 'package:bloc/bloc.dart';

import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_wathclist_event.dart';
part 'movie_wathclist_state.dart';

class MovieWathclistBloc extends Bloc<MovieWathclistEvent, MovieWathclistState> {
  final WatchListsMovie _watchListsMovie;
  MovieWathclistBloc(this._watchListsMovie) : super(MovieWathclistInitial()) {
    on<LoadMovieWatchlist>(_loadMovieWatchlist);
    on<DeleteMovieWatchlist>(_deleteMovieWatchList);
    on<AddMovieWatchlist>(_addToWatchlist);
    on<RemoveMovieWatchlist>(_removeFromWatchlist);
    on<CheckIsAddedMovieWatchlist>(_isAddedWatchList);
  }

  _loadMovieWatchlist(LoadMovieWatchlist event, Emitter<MovieWathclistState> emit) async {
    emit(MovieWatchlistLoading());
    final result = await _watchListsMovie.getData();
    result.fold((l) {
      emit(MovieWatchlistError(l.message));
    }, (r) {
      emit(MovieWatchlistLoaded(r));
    });
  }

  _addToWatchlist(AddMovieWatchlist event, Emitter<MovieWathclistState> emit) async {
    emit(MovieWathclistInitial());
    emit(MovieWatchlistLoading());
    final result = await _watchListsMovie.saveWatchlist(event.movie);
    result.fold((l) {
      emit(MovieWatchlistError(l.message));
    }, (r) {
      emit(MovieWatchlistSuccessAdd(r));
      emit(MovieWatchlistIsAdded());
    });
  }

  _removeFromWatchlist(RemoveMovieWatchlist event, Emitter<MovieWathclistState> emit) async {
    emit(MovieWatchlistLoading());
    final result = await _watchListsMovie.deleteWatchlist(event.movie);
    result.fold((l) {
      emit(MovieWatchlistError(l.message));
    }, (r) {
      emit(MovieWatchlistSuccessRemoved(r));
      emit(MovieWatchlistIsNotAdded());
    });
  }

  _isAddedWatchList(CheckIsAddedMovieWatchlist event, Emitter<MovieWathclistState> emit) async {
    final result = await _watchListsMovie.isAddWatchlist(event.id);
    if (result) {
      emit(MovieWatchlistIsAdded());
    } else {
      emit(MovieWatchlistIsNotAdded());
    }
  }

  _deleteMovieWatchList(DeleteMovieWatchlist event, Emitter<MovieWathclistState> emit) async {
    emit(MovieWatchlistLoading());

    final result = await _watchListsMovie.deleteWatchlist(event.movie);
    result.fold((l) {
      emit(MovieWatchlistError(l.message));
    }, (r) {
      emit(MovieWatchlistSuccessRemoved(r));
    });
  }
}

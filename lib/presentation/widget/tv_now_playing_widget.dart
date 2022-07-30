import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvNowPlayingWidget extends StatelessWidget {
  const TvNowPlayingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movie = <Movie>[];
    return BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(builder: (context, state) {
      if (state is TvNowPlayingLoaded) {
        state.tvList.forEach((tv) {
          movie.add(tv.tvToMovie());
        });
        return MovieListCard(
          tipe: "tv",
          length: 2,
          height: 500,
          isWatchlist: false,
          movies: movie,
          direction: Axis.vertical,
        );
      } else if (state is TvNowPlayingError) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
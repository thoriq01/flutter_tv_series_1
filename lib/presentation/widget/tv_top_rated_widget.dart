import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvTopRatedWidget extends StatelessWidget {
  const TvTopRatedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movie = <Movie>[];
    return BlocBuilder<TvTopRatedBloc, TvTopRatedState>(builder: (context, state) {
      if (state is TvTopRatedLoaded) {
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
      } else if (state is TvTopRatedError) {
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

import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvPopularWidget extends StatelessWidget {
  const TvPopularWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movie = <Movie>[];
    return BlocBuilder<TvPopularBloc, TvPopularState>(builder: (context, state) {
      if (state is TvPopularLoaded) {
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
      } else if (state is TvPopularError) {
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
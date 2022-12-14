import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvTopRatedWidget extends StatelessWidget {
  final String? idPage;
  const TvTopRatedWidget({
    Key? key,
    this.idPage,
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
          length: idPage == null ? 2 : state.tvList.length,
          height: idPage == null ? 500 : double.infinity,
          isWatchlist: false,
          movies: movie,
          direction: Axis.vertical,
        );
      } else if (state is TvTopRatedError) {
        return Center(
          child: Text(state.message, style: TextStyle(color: Colors.red)),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}

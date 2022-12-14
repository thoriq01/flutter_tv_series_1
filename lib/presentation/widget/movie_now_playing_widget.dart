import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieNowPlayingWidget extends StatelessWidget {
  const MovieNowPlayingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
      builder: (context, state) {
        print(state);
        if (state is MovienowPlayingLoading) {
          return CircularProgressIndicator();
        } else if (state is MovieNowPlayingError) {
          return Container(
            child: Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            ),
          );
        } else if (state is MovieNowPlayingLoaded) {
          if (state.movies.length > 0) {
            return MovieListCard(
              tipe: "movie",
              length: 2,
              isWatchlist: false,
              height: 500,
              movies: state.movies,
              isScrollable: false,
              direction: Axis.vertical,
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}

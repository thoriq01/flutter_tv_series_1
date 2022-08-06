import 'package:dicoding_tv_series/config/router/movie_route_name.dart';
import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:dicoding_tv_series/presentation/widget/title_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieWatchlistWidget extends StatelessWidget {
  final String tipe;
  const MovieWatchlistWidget({
    Key? key,
    required this.tipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieWathclistBloc, MovieWathclistState>(
      builder: (context, state) {
        if (state is MovieWatchlistLoading) {
          return Container();
        } else if (state is MovieWatchlistError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MovieWatchlistLoaded) {
          var loaded = <Movie>[];
          if (tipe == "movie") {
            state.movies.forEach((element) {
              if (element.tipe == 1) {
                loaded.add(element);
              }
            });
          } else {
            state.movies.forEach((element) {
              if (element.tipe == 2) {
                loaded.add(element);
              }
            });
          }
          if (loaded.length > 0) {
            return Container(
              child: Column(
                children: [
                  TitleContent(
                    text: tipe == "tv" ? "TV Watchlist" : "Movie Watchlist",
                    onPressed: () {
                      if (tipe == "tv") {
                        Navigator.pushNamed(context, tvTypeListPage, arguments: ListTypeTvArgument("watchlist"));
                      } else {
                        Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("watchlist"));
                      }
                    },
                  ),
                  MovieListCard(
                    tipe: tipe,
                    length: loaded.length,
                    isWatchlist: true,
                    isScrollable: true,
                    height: 300,
                    movies: loaded,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
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

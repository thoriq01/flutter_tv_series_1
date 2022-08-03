import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvTypeListPage extends StatefulWidget {
  final String category;
  const TvTypeListPage({Key? key, required this.category}) : super(key: key);

  @override
  _TvTypeListPageState createState() => _TvTypeListPageState();
}

class _TvTypeListPageState extends State<TvTypeListPage> {
  var movie = <Movie>[];

  @override
  void initState() {
    super.initState();
    if (this.widget.category == "tvpopular") {
      context.read<TvPopularBloc>().add(LoadTvPopular());
    } else if (this.widget.category == "tvtoprated") {
      context.read<TvTopRatedBloc>().add(LoadTvTopRated());
    } else if (this.widget.category == "watchlist") {
      context.read<MovieWathclistBloc>().add(LoadMovieWatchlist());
    } else {
      context.read<TvNowPlayingBloc>().add(LoadTvNowPlaying());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _appBarTitle(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Builder(builder: (context) {
            if (this.widget.category == "toprated") {
              return BlocBuilder<TvTopRatedBloc, TvTopRatedState>(builder: (context, state) {
                if (state is TvTopRatedLoaded) {
                  state.tvList.forEach((tv) {
                    movie.add(tv.tvToMovie());
                  });
                  return MovieListCard(
                    tipe: "tv",
                    length: state.tvList.length,
                    isWatchlist: false,
                    height: double.infinity,
                    isScrollable: true,
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
            } else if (this.widget.category == "tvpopular") {
              return BlocBuilder<TvPopularBloc, TvPopularState>(builder: (context, state) {
                if (state is TvPopularLoaded) {
                  state.tvList.forEach((tv) {
                    movie.add(tv.tvToMovie());
                  });
                  return MovieListCard(
                    tipe: "tv",
                    length: state.tvList.length,
                    height: MediaQuery.of(context).size.width * 100,
                    isWatchlist: false,
                    isScrollable: true,
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
            } else if (this.widget.category == "watchlist") {
              return BlocBuilder<MovieWathclistBloc, MovieWathclistState>(
                builder: (context, state) {
                  if (state is MovieWatchlistLoading) {
                    return CircularProgressIndicator();
                  } else if (state is MovieWatchlistError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is MovieWatchlistLoaded) {
                    if (state.movies.length > 0) {
                      return Container(
                        child: MovieListCard(
                          tipe: "tv",
                          length: state.movies.length,
                          isWatchlist: false,
                          isScrollable: true,
                          height: MediaQuery.of(context).size.height,
                          movies: state.movies,
                          direction: Axis.vertical,
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
            } else {
              return BlocBuilder<TvNowPlayingBloc, TvNowPlayingState>(
                builder: (context, state) {
                  if (state is MovienowPlayingLoading) {
                    return CircularProgressIndicator();
                  } else if (state is TvNowPlayingError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is TvNowPlayingLoaded) {
                    if (state.tvList.length > 0) {
                      state.tvList.forEach((tv) {
                        movie.add(tv.tvToMovie());
                      });
                      return Container(
                        child: MovieListCard(
                          tipe: "tv",
                          length: state.tvList.length,
                          isWatchlist: false,
                          height: MediaQuery.of(context).size.height,
                          isScrollable: true,
                          movies: movie,
                          direction: Axis.vertical,
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
          }),
        ),
      ),
    );
  }

  _appBarTitle() {
    if (this.widget.category == "tvtoprated") {
      return Text(
        "Tv Top Rated",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    } else if (this.widget.category == "tvpopular") {
      return Text(
        "Tv Popular",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    } else if (this.widget.category == "watchlist") {
      return Text(
        "Watchlist",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    } else {
      return Text(
        "Tv Now Playing",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    }
  }
}

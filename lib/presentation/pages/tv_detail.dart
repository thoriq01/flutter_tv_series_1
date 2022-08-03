import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_tv_series/config/router/movie_route_name.dart';
import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_recomendation_bloc/tv_recomendation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailPage extends StatefulWidget {
  final MovieDetail? movie;
  final String? tipe;
  const TvDetailPage({Key? key, this.movie, this.tipe}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvDetailBloc>().add(LoadTvDetailEvent(this.widget.movie!.id!));
    context.read<MovieWathclistBloc>().add(CheckIsAddedMovieWatchlist(this.widget.movie!.id!));
    context.read<TvRecomendationBloc>().add(LoadTvRecomendationEvent(this.widget.movie!.id!));
  }

  var movieData = <Movie>[];

  @override
  Widget build(BuildContext context) {
    var detail = MovieDetail(
      adult: this.widget.movie!.adult,
      overview: this.widget.movie!.overview,
      id: this.widget.movie!.id,
      posterPath: this.widget.movie!.posterPath,
      title: this.widget.movie!.title,
      tipe: 2,
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BlocBuilder<TvDetailBloc, TvDetailState>(
                    builder: (context, state) {
                      if (state is TvDetailLoading) {
                        return MovieLoadingData();
                      } else if (state is TvDetailLoaded) {
                        var stateTv = state.tvDetail.tvToMovie();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${stateTv.posterPath}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, movieListPage);
                                },
                                icon: Center(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    stateTv.title,
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      stateTv.releaseDate,
                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            Row(
                              children: [
                                ...stateTv.genre.map((e) {
                                  return Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        e.name,
                                        style: TextStyle(fontSize: 14, color: Colors.white70),
                                      ));
                                })
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.orangeAccent, size: 20),
                                Text(
                                  (stateTv.voteAverage).toString(),
                                  style: TextStyle(fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Overview",
                                  style: TextStyle(fontSize: 18, color: Colors.white70),
                                ),
                                TvWatchList(movie: this.widget.movie!),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              stateTv.overview,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            // Text(state.movieDetail)
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(""),
                        );
                      }
                    },
                  ),
                  BlocBuilder<TvRecomendationBloc, TvRecomendationState>(
                    builder: (context, state) {
                      if (state is TvRecomendationLoading) {
                        return MovieLoadingData();
                      } else if (state is TvRecomendationLoaded) {
                        state.tvRecomendation.forEach((e) {
                          movieData.add(e.tvToMovie());
                        });
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recomendation",
                              style: TextStyle(fontSize: 18, color: Colors.white70),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 200,
                              child: Recomendationwidget(movie: movieData, tipe: "tipe"),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(""),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TvWatchList extends StatelessWidget {
  final MovieDetail movie;
  const TvWatchList({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showNotification(BuildContext context, String text) {
      return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: 100,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Center(
            child: Text(text, style: TextStyle(color: Colors.black)),
          ),
        ),
      );
    }

    return BlocConsumer<MovieWathclistBloc, MovieWathclistState>(
      listener: (context, state) {
        if (state is MovieWatchlistSuccessAdd) {
          _showNotification(context, "Added to watchlist");
        } else if (state is MovieWatchlistSuccessRemoved) {
          _showNotification(context, "Removed from watchlist");
        }
      },
      builder: (context, state) {
        if (state is MovieWatchlistIsAdded) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(primary: Colors.red, elevation: 1, backgroundColor: Colors.white12),
            child: Text("Remove Watchlist"),
            onPressed: () {
              context.read<MovieWathclistBloc>().add(RemoveMovieWatchlist(movie));
            },
          );
        } else {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            child: Text(
              "Add To Watchlist",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              context.read<MovieWathclistBloc>().add(
                    AddMovieWatchlist(
                      MovieDetail(
                        id: movie.id,
                        title: movie.title,
                        overview: movie.overview,
                        posterPath: movie.posterPath,
                        tipe: 2,
                      ),
                    ),
                  );
            },
          );
        }
      },
    );
  }
}

class Recomendationwidget extends StatelessWidget {
  final List<Movie> movie;
  final String tipe;
  const Recomendationwidget({
    Key? key,
    required this.movie,
    required this.tipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movie.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(movie[index].movie(), tipe)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${movie[index].backdropPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                child: Text(
                  movie[index].title!,
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MovieLoadingData extends StatelessWidget {
  const MovieLoadingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}

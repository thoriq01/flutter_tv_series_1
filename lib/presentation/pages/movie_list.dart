import 'package:dicoding_tv_series/config/router/movie_route_name.dart';
import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_card.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_now_playing_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_popular_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_toprated_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_watchlist_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/title_content.dart';
import 'package:dicoding_tv_series/presentation/widget/tv_now_playing_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/tv_popular_widget.dart';
import 'package:dicoding_tv_series/presentation/widget/tv_top_rated_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> with SingleTickerProviderStateMixin {
  var _searchMovie = TextEditingController();
  var _searchTv = TextEditingController();
  TabController? controller;

  @override
  void initState() {
    super.initState();
    context.read<MoviePopularBlocBloc>().add(LoadPopularMovie());
    context.read<MovieTopRatedBloc>().add(LoadMovieTopRated());
    context.read<MovieSearchBloc>().add(RemoveSearchMovieEvent());
    context.read<TvSearchBloc>().add(RemoveSearchTvEvent());
    context.read<MovieWathclistBloc>().add(LoadMovieWatchlist());
    context.read<MovieNowPlayingBloc>().add(LoadMovieNowPlaying());
    context.read<TvPopularBloc>().add(LoadTvPopular());
    context.read<TvTopRatedBloc>().add(LoadTvTopRated());
    context.read<TvNowPlayingBloc>().add(LoadTvNowPlaying());

    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(29, 39, 39, 0),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: controller!.index,
          child: Container(
            color: Color.fromRGBO(29, 39, 39, 0),
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              controller: controller,
              children: [
                MovieAndTvPage(tipe: "movie", searchMovie: _searchMovie),
                MovieAndTvPage(tipe: "tv", searchMovie: _searchTv),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: TabBar(
          onTap: (value) {
            // FirebaseCrashlytics.instance.crash();

            setState(() {});
          },
          unselectedLabelColor: Colors.grey.shade300,
          padding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          controller: controller,
          tabs: [
            Tab(
              icon: Icon(Icons.movie_creation_outlined),
            ),
            Tab(
              icon: Icon(Icons.tv),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieAndTvPage extends StatelessWidget {
  final String? tipe;
  const MovieAndTvPage({
    Key? key,
    required TextEditingController searchMovie,
    this.tipe,
  })  : _searchMovie = searchMovie,
        super(key: key);

  final TextEditingController _searchMovie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Search",
                  style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (tipe == "tv") {
                    Navigator.pushNamed(context, tvTypeListPage, arguments: ListTypeTvArgument("watchlist"));
                  } else {
                    Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("watchlist"));
                  }
                },
                icon: Icon(
                  Icons.movie_creation,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SearchWidget(
            searchMovie: _searchMovie,
            tipe: tipe,
          ),
          SizedBox(height: 20),
          tipe == "tv" ? TvWidget() : MovieWidget(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MovieWidget extends StatelessWidget {
  const MovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSearchBloc, MovieSearchBlocState>(builder: (context, state) {
      if (state is MovieSearchBlocLoaded) {
        return MovieSearchWidget(movies: state.movies);
      } else if (state is MovieSearchBlocError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is MovieSearchBlocLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is MovieSearchBlocEmpty) {
        return Builder(builder: (context) {
          return Column(
            children: [
              MovieWatchlistWidget(
                tipe: "movie",
              ),
              TitleContent(
                text: "Now Playing",
                onPressed: () {
                  Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("nowplaying"));
                },
              ),
              MovieNowPlayingWidget(),
              TitleContent(
                text: "Popular",
                onPressed: () {
                  Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("popular"));
                },
              ),
              MoviePopularBlocWidget(),
              TitleContent(
                  text: "Top Movie",
                  onPressed: () {
                    Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("topmovie"));
                  }),
              MovieTopRatedWidget(),
            ],
          );
        });
      } else {
        return Center(
          child: Container(),
        );
      }
    });
  }
}

class MovieSearchWidget extends StatelessWidget {
  final List<Movie> movies;
  const MovieSearchWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (movies.length),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (movies.length == 0) {
            return Center(
              child: Text('No Data', style: TextStyle(color: Colors.white, fontSize: 20)),
            );
          }
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(movies[index].movie(), "movies"));
            },
            leading: Container(
              child: Image(
                image: NetworkImage("https://image.tmdb.org/t/p/w500/${movies[index].posterPath!}"),
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ),
            title: Text(
              movies[index].title!,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
          );
        },
      ),
    );
  }
}

class TvWidget extends StatelessWidget {
  const TvWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSearchBloc, TvSearchState>(builder: (context, state) {
      if (state is TvSearchLoaded) {
        var movies = <Movie>[];
        state.tvList.forEach((element) {
          movies.add(element.tvToMovie());
        });
        return TvSearchWidget(movies: movies);
      } else if (state is TvSearchError) {
        return Center(
          child: Text(state.message),
        );
      } else if (state is TvSearchLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TvSearchEmpty) {
        return Column(
          children: [
            MovieWatchlistWidget(
              tipe: "tv",
            ),
            TitleContent(
              text: "Tv Now Playing",
              onPressed: () {
                Navigator.pushReplacementNamed(context, tvTypeListPage, arguments: ListTypeTvArgument("tvnowplaying"));
              },
            ),
            TvNowPlayingWidget(),
            TitleContent(
              text: "Tv Popular",
              onPressed: () {
                Navigator.pushReplacementNamed(context, tvTypeListPage, arguments: ListTypeTvArgument("tvpopular"));
              },
            ),
            TvPopularWidget(),
            TitleContent(
                text: "Top Top Rated",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, tvTypeListPage, arguments: ListTypeTvArgument("tvtoprated"));
                }),
            TvTopRatedWidget(),
          ],
        );
      } else {
        return Center(
          child: Container(),
        );
      }
    });
  }
}

class TvSearchWidget extends StatelessWidget {
  final List<Movie> movies;

  const TvSearchWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (movies.length),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (movies.length == 0) {
            return Center(
              child: Text('No Data', style: TextStyle(color: Colors.white, fontSize: 20)),
            );
          }
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, tvDetailPage, arguments: DetailTvArgument(movies[index].movie(), "tv"));
              },
              leading: Container(
                child: Image(
                  image: NetworkImage("https://image.tmdb.org/t/p/w500/${movies[index].posterPath!}"),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 120,
                ),
              ),
              title: Text(
                movies[index].title!,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final String? tipe;
  const SearchWidget({
    Key? key,
    required TextEditingController searchMovie,
    this.tipe,
  })  : _searchMovie = searchMovie,
        super(key: key);

  final TextEditingController _searchMovie;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      controller: _searchMovie,
      decoration: InputDecoration(
        hintText: tipe == "tv" ? "Tv Name" : "Name of Movie , Actors",
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: 18,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 1, style: BorderStyle.solid),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
      ),
      onChanged: (value) {
        print(tipe);
        if (tipe == "tv") {
          if (value.length > 1) {
            context.read<TvSearchBloc>().add(SearchTvEvent(value));
          } else {
            context.read<TvSearchBloc>().add(RemoveSearchTvEvent());
          }
        } else {
          if (value.length > 1) {
            context.read<MovieSearchBloc>().add(SearchMovieEvent(value));
          } else {
            context.read<MovieSearchBloc>().add(RemoveSearchMovieEvent());
          }
        }
      },
    );
  }
}

class MovieListCard extends StatelessWidget {
  final String tipe;
  final int length;
  final List<Movie> movies;
  final bool isScrollable;
  final Axis direction;
  final double height;
  final bool isWatchlist;
  const MovieListCard({
    Key? key,
    required this.length,
    required this.direction,
    required this.movies,
    required this.height,
    required this.isWatchlist,
    this.isScrollable = false,
    required this.tipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.builder(
        scrollDirection: direction,
        physics: isScrollable == false ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
        itemCount: length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (tipe == "tv") {
                Navigator.pushNamed(context, tvDetailPage, arguments: DetailTvArgument(movies[index].movie(), tipe));
              } else {
                Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(movies[index].movie(), tipe));
              }
            },
            child: MovieCard(
              title: movies[index].title,
              posterPath: movies[index].posterPath,
              date: movies[index].releaseDate,
              overview: movies[index].overview,
              isWatchlist: isWatchlist,
            ),
          );
        },
      ),
    );
  }
}

//               Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(state.movies[index].movie()));

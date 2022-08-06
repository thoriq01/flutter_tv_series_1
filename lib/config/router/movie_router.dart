import 'package:dicoding_tv_series/config/router/movie_route_name.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_detail.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_type_list.dart';
import 'package:dicoding_tv_series/presentation/pages/tv_detail.dart';
import 'package:dicoding_tv_series/presentation/pages/tv_type_list.dart';
import 'package:flutter/material.dart';

class MovieRouter {
  MovieRouter();

  static Route movieRouterPage(RouteSettings setting) {
    switch (setting.name) {
      case movieListPage:
        return MaterialPageRoute(builder: (context) => MovieListPage());
      case movieDetailPage:
        var s = setting.arguments as DetailMovieArgument;
        return MaterialPageRoute(builder: (context) => MovieDetailPage(movie: s.movie, tipe: s.tipe));
      case movieTypeListPage:
        var s = setting.arguments as ListTypeMovieArgument;
        return MaterialPageRoute(builder: (context) => MovieTypeListPage(category: s.category));
      case tvDetailPage:
        var s = setting.arguments as DetailTvArgument;
        return MaterialPageRoute(
            builder: (context) => TvDetailPage(
                  movie: s.tv,
                  tipe: s.tipe,
                ));
      case tvTypeListPage:
        var s = setting.arguments as ListTypeTvArgument;
        return MaterialPageRoute(builder: (context) => TvTypeListPage(category: s.category));
      default:
        return MaterialPageRoute(builder: (context) => MovieListPage());
    }
  }
}

class DetailMovieArgument {
  final MovieDetail movie;
  final String tipe;
  DetailMovieArgument(this.movie, this.tipe);
}

class DetailTvArgument {
  final MovieDetail tv;
  final String tipe;

  DetailTvArgument(this.tv, this.tipe);
}

class ListTypeMovieArgument {
  final String category;
  ListTypeMovieArgument(this.category);
}

class ListTypeTvArgument {
  final String category;
  ListTypeTvArgument(this.category);
}

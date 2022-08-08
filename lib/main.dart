import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_cast_bloc/movie_cast_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_now_playing_bloc/tv_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_recomendation_bloc/tv_recomendation_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'injector.dart' as dl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  dl.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviePopularBlocBloc>(
          create: (context) => dl.sl<MoviePopularBlocBloc>(),
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => dl.sl<MovieTopRatedBloc>(),
        ),
        BlocProvider<MovieSearchBloc>(
          create: (context) => dl.sl<MovieSearchBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (context) => dl.sl<MovieDetailBloc>(),
        ),
        BlocProvider<MovieCastBloc>(
          create: (context) => dl.sl<MovieCastBloc>(),
        ),
        BlocProvider<MovieWathclistBloc>(
          create: (context) => dl.sl<MovieWathclistBloc>(),
        ),
        BlocProvider<MovieRecomendationBloc>(
          create: (context) => dl.sl<MovieRecomendationBloc>(),
        ),
        BlocProvider<MovieNowPlayingBloc>(
          create: (context) => dl.sl<MovieNowPlayingBloc>(),
        ),
        BlocProvider<TvPopularBloc>(
          create: (context) => dl.sl<TvPopularBloc>(),
        ),
        BlocProvider<TvNowPlayingBloc>(
          create: (context) => dl.sl<TvNowPlayingBloc>(),
        ),
        BlocProvider<TvTopRatedBloc>(
          create: (context) => dl.sl<TvTopRatedBloc>(),
        ),
        BlocProvider<TvRecomendationBloc>(
          create: (context) => dl.sl<TvRecomendationBloc>(),
        ),
        BlocProvider<TvDetailBloc>(
          create: (context) => dl.sl<TvDetailBloc>(),
        ),
        BlocProvider<TvSearchBloc>(
          create: (context) => dl.sl<TvSearchBloc>(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          title: 'TV SERIES',
          onGenerateRoute: MovieRouter.movieRouterPage,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Color.fromRGBO(29, 39, 39, 0),
            appBarTheme: AppBarTheme(
              color: Color.fromRGBO(29, 39, 39, 0),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}

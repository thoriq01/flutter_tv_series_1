import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/tv.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class TvSeries {
  final MovieRepository repository;

  TvSeries(this.repository);

  Future<Either<Failure, List<Tv>>> getNowPlayingTv() {
    return repository.getNowPlayingTv();
  }

  Future<Either<Failure, List<Tv>>> getPopularTv() {
    return repository.getPopularTv();
  }

  Future<Either<Failure, List<Tv>>> getTopRatedTv() {
    return repository.getTopRatedTv();
  }
}

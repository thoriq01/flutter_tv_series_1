import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
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

  Future<Either<Failure, Tv>> getTvDetail(int id) {
    return repository.getTvDetail(id);
  }

  Future<Either<Failure, List<Tv>>> getTvRecomendation(int id) {
    return repository.getTvRecomendation(id);
  }

  Future<Either<Failure, List<Tv>>> searchTv(String query) {
    return repository.searchTv(query);
  }
}

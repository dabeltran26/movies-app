import 'package:equatable/equatable.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MoviesState extends Equatable{

  @override
  List<Object> get props => throw UnimplementedError();

}

class InitMovieState extends MoviesState{

  final List<Movie> moviesPopular;
  final List<Movie> moviePlaying;
  InitMovieState(this.moviesPopular,this.moviePlaying);

  @override
  String toString() => 'SectionsLoaded{genres: $moviesPopular}';
}

class LoadState extends MoviesState{

}
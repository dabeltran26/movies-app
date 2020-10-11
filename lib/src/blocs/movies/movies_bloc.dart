import 'package:movies_app/src/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesRepository repository;

  @override
  MoviesState get initialState => LoadState();

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async*{
    repository = MoviesRepository();

    if (event is InitEvent){
      yield* _getMovies();
    }
  }

  Stream<MoviesState> _getMovies() async* {
    try {
      final moviesPopular = await this.repository.getPopularMovies();
      final moviesPlaying = await this.repository.getNowPlayingMovies();

      yield InitMovieState(moviesPopular,moviesPlaying);
    } catch (_) {
      yield LoadState();
    }
  }

}
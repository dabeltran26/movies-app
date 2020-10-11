import 'package:movies_app/src/repository/repository.dart';
import 'package:bloc/bloc.dart';

import 'actors_event.dart';
import 'actors_state.dart';

class ActorsBloc extends Bloc<ActorsEvent, ActorsState> {
  MoviesRepository repository;

  @override
  ActorsState get initialState => LoadState();

  @override
  Stream<ActorsState> mapEventToState(ActorsEvent event) async*{
    repository = MoviesRepository();

    if (event is InitEvent){
      yield* _getActors(event.movieID);
    }
  }

  Stream<ActorsState> _getActors(String movieID) async* {
    try {
      final actors = await this.repository.getCast(movieID);
      yield InitActorState(actors);
    } catch (_) {
      yield LoadState();
    }
  }

}
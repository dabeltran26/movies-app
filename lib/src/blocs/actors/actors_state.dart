import 'package:equatable/equatable.dart';
import 'package:movies_app/src/models/actor_model.dart';

class ActorsState extends Equatable{

  @override
  List<Object> get props => throw UnimplementedError();

}

class InitActorState extends ActorsState{

  final List<Actor> actors;
  InitActorState(this.actors);

  @override
  String toString() => 'SectionsLoaded{genres: $actors}';
}

class LoadState extends ActorsState{

}
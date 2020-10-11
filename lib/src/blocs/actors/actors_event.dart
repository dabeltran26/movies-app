import 'package:equatable/equatable.dart';

class ActorsEvent extends Equatable{
  @override
  List<Object> get props => throw UnimplementedError();
}

class InitEvent extends ActorsEvent{
  final String movieID;
  InitEvent(this.movieID);
  @override
  String toString() => 'SectionsLoaded{genres: $movieID}';
}

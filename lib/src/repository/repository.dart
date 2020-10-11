import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/actor_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:movies_app/src/models/movie_model.dart';

class MoviesRepository {

  String _apikey   = 'ec3dc753b3c0b55dba3d3e498f38cd18';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> _popular = new List();
  List<Movie> _palying = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();
  final _playingStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Function(List<Movie>) get payingSink => _playingStreamController.sink.add;


  void disposeStreams() {
    _popularStreamController?.close();
    _playingStreamController?.close();
  }

  Future<List<Movie>> response(Uri url) async {
    
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    
    return movies.items;
  }

  Future<List<Movie>> getNowPlayingMovies() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apikey,
      'language' : _language
    });
    final resp = await response(url);

    _palying.addAll(resp);
    payingSink(_palying);

    return resp;
  }

  Future<List<Movie>> getPopularMovies() async {

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apikey,
      'language' : _language,
      //'page'     : _popularPage.toString()
    });

    final resp = await response(url);

    _popular.addAll(resp);
    popularSink( _popular );

    return resp;

  }

  Future<List<Actor>> getCast( String movieID ) async {

    final url = Uri.https(_url, '3/movie/$movieID/credits', {
      'api_key'  : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode( resp.body );

    final cast = new Actors.fromJsonList(decodedData['cast']);

    return cast.actors;

  }

  Future<List<Movie>> buscarPelicula( String query ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    });

    return await response(url);

  }

}


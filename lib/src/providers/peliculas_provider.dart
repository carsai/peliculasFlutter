import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaProvider {
  final String _apikey = '1016f71811cdd595a25b239bfdff85b6';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';
  
  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = List();

  // Se añade broadcast para que pueda ser usado por varios a la vez en vez de solo 1
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'  : _apikey,
      'language' : _language
    });

    return await _llamarApi(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'  : _apikey,
      'language' : _language,
      'page'     : _popularesPage.toString()
    });

    final respuesta = await _llamarApi(url);

    _populares.addAll(respuesta);

    this.popularesSink(_populares);

    _cargando = false;

    return respuesta;
  }


  Future<List<Actor>> getCast(String peliculaId) async {
    final url = Uri.https(_url, '3/movie/$peliculaId/credits', {
      'api_key'  : _apikey
    });

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    });

    return await _llamarApi(url);
  }

  Future<List<Pelicula>> _llamarApi(Uri url) async {
    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

}
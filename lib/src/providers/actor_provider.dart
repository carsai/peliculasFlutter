import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_detalle_model.dart';


class ActorProvider {
  final String _apikey = '1016f71811cdd595a25b239bfdff85b6';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';

  bool _primeraVez = true;

  Future<ActorDetalle> getActorDetalle(String codigoActor) async {
    if (!_primeraVez) return null;

    _primeraVez = false;

    final url = Uri.https(_url, '3/person/$codigoActor', {
      'api_key'  : _apikey,
      'language' : _language
    });

    final respuesta = await http.get(url);

    final respuestaJson = json.decode(respuesta.body);

    final actor = ActorDetalle.fromJsonMap(respuestaJson);

    return actor;
  }
}
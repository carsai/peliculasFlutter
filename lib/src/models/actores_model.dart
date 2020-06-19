import 'package:flutter/material.dart';
import 'package:peliculas/src/util/imagen_util.dart';

class Cast {

  List<Actor> actores = List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((actor) => actores.add( Actor.fromJsonMap(actor)));
  }
}

class Actor {

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId       = json['cast_id'];
    character    = json['character'];
    creditId     = json['credit_id'];
    gender       = json['gender'];
    id           = json['id'];
    name         = json['name'];
    order        = json['order'];
    profilePath  = json['profile_path'];
  }
  
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  ImageProvider<dynamic> getFoto() {
    if (profilePath == null)
      return UtilImagen.imagenDefaultAvatar();
    return NetworkImage('https://image.tmdb.org/t/p/w500/$profilePath');
  }
}

import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/util/imagen_util.dart';

class DataSearch extends SearchDelegate {

  final _peliculaProvider = PeliculaProvider();

  String seleccion = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
      ), 
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.yellowAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
      return Container();

    return FutureBuilder(
      future: _peliculaProvider.buscarPelicula(query),
      builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {        
        if(snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map(
              (pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: UtilImagen.imagenLoading(), 
                    image: pelicula.getPosterImg(),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.idHero = '${pelicula.id}search';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }
            ).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}
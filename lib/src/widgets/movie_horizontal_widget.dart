import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/util/imagen_util.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguintePagina;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  MovieHorizontal({@required this.peliculas, @required this.siguintePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        this.siguintePagina();
      }
     });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: peliculas.length,
        controller: _pageController,
        itemBuilder: _tarjeta,
      ),
    );
  }

  Widget _tarjeta (BuildContext context, int i) {
    peliculas[i].idHero = '${peliculas[i].id}hhh';
    final peliculaTarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: peliculas[i].idHero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: UtilImagen.imagenLoading(), 
                  image: peliculas[i].getPosterImg(),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              peliculas[i].title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

      return GestureDetector(
        onTap: () { 
          Navigator.pushNamed(context, 'detalle', arguments: peliculas[i]);
        },
        child: peliculaTarjeta,
      );
  }

  /*List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: UtilImagen.imagenLoading(), 
                image: pelicula.getPosterImg(),
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
  */
}
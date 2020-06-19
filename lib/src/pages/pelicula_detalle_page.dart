import 'package:flutter/material.dart';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';

import 'package:peliculas/src/util/imagen_util.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppBar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10.0,),
                  _posterTitulo(context, pelicula),
                  _descripcion(pelicula),
                  _crearCasting(pelicula),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

 Widget _crearAppBar(Pelicula pelicula) {
   return SliverAppBar(
     elevation: 2.0,
     backgroundColor: Colors.indigo,
     expandedHeight: 200.0,
     floating: false,
     pinned: true,
     flexibleSpace: FlexibleSpaceBar(
       centerTitle: true,
       title: Text(
         pelicula.title,
         style: TextStyle(
           color: Colors.white,
           fontSize: 16.0
         ),
       ),
       background: FadeInImage(
         placeholder: UtilImagen.imagenLoading(), 
         image: pelicula.getBackFropImg(),
         fadeInDuration: Duration(milliseconds: 250),
         fit: BoxFit.cover,
       ),
     ),
   );
 }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.idHero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
               image:pelicula.getPosterImg(),
               height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                   style: Theme.of(context).textTheme.subtitle1,
                   overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliculaProvider = PeliculaProvider();

    return FutureBuilder(
      future: peliculaProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          ); 
        } 
      },
  );
        
  }
        
  Widget _crearActoresPageView(List<Actor> actores) {
    
    return SizedBox(
      height: 230.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, index) => _actorTarjeta(context, actores[index]),
      ),
    );
  }

  Widget _actorTarjeta(BuildContext context, Actor actor) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle_actor', arguments: actor);
      },
      child: Container(
        child: Column(
          children: <Widget>[          
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: UtilImagen.imagenLoading(), 
                image: actor.getFoto(),
                height: 150.0,
                width: 120.0,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
            ),
            Text('Es'),
            Text(
              actor.character,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
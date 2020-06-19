import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/util/imagen_util.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required  this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
     padding: EdgeInsets.only(top: 10),
     child: Swiper(
       layout: SwiperLayout.STACK,
       itemWidth: _screenSize.width * 0.7,
       itemHeight: _screenSize.height * 0.5,
       itemBuilder: (context, index) {
         peliculas[index].idHero = '${peliculas[index].id}ddd';
         return Hero(
           tag: peliculas[index].idHero,
           child: GestureDetector(
             onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
             child: ClipRRect(
               borderRadius: BorderRadius.circular(20),
               child: FadeInImage(
                placeholder: UtilImagen.imagenLoading(), 
                image: peliculas[index].getPosterImg(),
                fit: BoxFit.cover,
               ),
             ),
           ),
         ); 
       },
       itemCount: peliculas.length,
       //pagination: SwiperPagination(),
       //control: SwiperControl()
     ),
   );
  }
}
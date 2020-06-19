import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_detalle_model.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/providers/actor_provider.dart';
import 'package:peliculas/src/util/imagen_util.dart';

class ActorDetallePage extends StatelessWidget { 
    
    final actorProvider = ActorProvider();

  @override
  Widget build(BuildContext context) {

    final Actor actor = ModalRoute.of(context).settings.arguments;


    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppBar(actor),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _datosActor(context, actor)
                ]
              )
            )
          ],
        )
      ),
    );
  }

  Widget _crearAppBar(Actor actor) {
   return SliverAppBar(
     elevation: 2.0,
     backgroundColor: Colors.indigo,
     expandedHeight: 200.0,
     floating: false,
     pinned: true,
     flexibleSpace: FlexibleSpaceBar(
       centerTitle: true,
       title: Text(
         actor.name,
         style: TextStyle(
           color: Colors.white,
           fontSize: 16.0
         ),
       ),
       background: FadeInImage(
         placeholder: UtilImagen.imagenLoading(), 
         image: actor.getFoto(),
         fadeInDuration: Duration(milliseconds: 250),
         fit: BoxFit.cover,
       ),
     ),
   );
 }

 Widget _datosActor(BuildContext context, Actor actor) {
   return FutureBuilder(
    future: actorProvider.getActorDetalle(actor.id.toString()),
    builder: (context, AsyncSnapshot<ActorDetalle> snapshot) {
      if(snapshot.hasData) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(          
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Biografia',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                snapshot.data.biography,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Fecha de nacimiento',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Text('${snapshot.data.birthday}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Lugar de nacimiento',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Text('${snapshot.data.placeOfBirth}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Muerte',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Text('${snapshot.data.deathday}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Conocido como',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.data.alsoKnownAs.map((e) => Text(e) ).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sexo',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 20,
              ),
              Text((snapshot.data.gender == 2) ? 'Hombre' : 'Mujer',
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        );
      } else {
        return CircularProgressIndicator();
      }
    },
   );
 }
}
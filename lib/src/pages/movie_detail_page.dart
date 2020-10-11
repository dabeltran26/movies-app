import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/actors/actors_bloc.dart';
import 'package:movies_app/src/blocs/actors/actors_event.dart';
import 'package:movies_app/src/blocs/actors/actors_state.dart';
import 'package:movies_app/src/common/colors.dart';
import 'package:movies_app/src/common/text_style.dart';
import 'package:movies_app/src/models/actor_model.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/repository/repository.dart';

class MovieDetail extends StatefulWidget {
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  ActorsBloc bloc;

  @override
  void initState() {
    bloc = ActorsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: Container(
            color: GeneralColors.steelBlue,
            child: BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, ActorsState state) {
                if (state is LoadState) {
                  bloc.add(InitEvent(movie.id.toString()));
                }

                if (state is InitActorState) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      _createPrincipalImage(movie),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(movie.title,
                                style: GeneralTextStyles.menuTittle
                                    .copyWith(fontSize: 20),
                                overflow: TextOverflow.ellipsis),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Text(movie.overview,
                                textAlign: TextAlign.justify,
                                style: GeneralTextStyles.menuTittle
                                    .copyWith(fontSize: 16)),
                          ),
                          SizedBox(height: 10.0),
                          _createCasting(movie),
                        ]),
                      )
                    ],
                  );
                }

                return Container();
              },
            )));
  }

  Widget _createPrincipalImage(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: GeneralColors.steelBlue,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Image.network(
            movie.getBackgroundImg(),
            fit: BoxFit.cover,
          )),
    );
  }

// Colocar Actores
  Widget _createCasting(Movie movie) {
    final peliProvider = new MoviesRepository();
    return FutureBuilder(
      future: peliProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createCardsActor(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

//Crear las tarjetas de los actores
  Widget _createCardsActor(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actors.length,
        itemBuilder: (context, i) => _actorCard(actors[i]),
      ),
    );
  }

// Widget para cada actor
  Widget _actorCard(Actor actor) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(actor.getFoto())))),
        SizedBox(
          height: 10,
        ),
        Text(actor.name,
            overflow: TextOverflow.ellipsis,
            style: GeneralTextStyles.menuTittle.copyWith(fontSize: 14))
      ],
    ));
  }
}

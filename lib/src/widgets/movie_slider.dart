import 'package:flutter/material.dart';
import 'package:movies_app/src/common/text_style.dart';
import 'package:movies_app/src/models/movie_model.dart';


class MovieSlider extends StatelessWidget {

  final List<Movie> movies;

  MovieSlider({ @required this.movies});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );


  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: ( context, i ) => _movieCard(context, movies[i] ),
      ),
    );
  }

  //Tarjetas de cada pelicula
  Widget _movieCard(BuildContext context, Movie movie) {

    movie.uniqueId = '${ movie.id }-poster';
    final card = Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            Image.network(movie.getPosterImg()),
            SizedBox(height: 3.0),
            Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                style: GeneralTextStyles.menuTittle
            )
          ],
        ),
      );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, 'detail', arguments: movie );
      },
    );

  }

}

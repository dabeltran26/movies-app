import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/blocs/movies/movies_bloc.dart';
import 'package:movies_app/src/blocs/movies/movies_event.dart';
import 'package:movies_app/src/blocs/movies/movies_state.dart';
import 'package:movies_app/src/common/colors.dart';
import 'package:movies_app/src/common/text_style.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/repository/repository.dart';
import 'package:movies_app/src/widgets/movie_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MoviesRepository moviesRepository;
  MoviesBloc bloc;

  @override
  void initState() {
    moviesRepository = MoviesRepository();
    bloc = MoviesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    moviesRepository.getPopularMovies();

    return Scaffold(
        body: Container(
      color: GeneralColors.skyBlue,
      child: BlocBuilder(
        bloc: bloc,
        builder: builder,
      ),
    ));
  }


  Widget builder(BuildContext context, MoviesState state) {
    final _screenSize = MediaQuery.of(context).size;

    if(state is LoadState){
      bloc.add(InitEvent());
    }

    if (state is InitMovieState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 50, right: 50),
            child: Container(
              child: Text(
                'Hello, what do you want to watch ?',
                style: GeneralTextStyles.tittleBold,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          searchBar(),
          SizedBox(
            height: 80,
          ),
          movies(context, _screenSize,state.moviesPopular,state.moviePlaying)
        ],
      );
    }
    return Container();
  }

  Widget searchBar() {
    return Container();
  }

  Widget movies(BuildContext context, Size screenSize, List<Movie> moviesPopular,List<Movie> moviesPlaying) {
    return Container(
      height: screenSize.height*0.6,
      width: screenSize.width,
      decoration: BoxDecoration(
          color: GeneralColors.steelBlue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'RECOMMENDED FOR YOU',
            style: GeneralTextStyles.menuTittle,
          ),
          SizedBox(
            height: 5,
          ),
          listMovies(context,moviesPopular),
          SizedBox(
            height: 5,
          ),
          Text(
            'TOP RATED',
            style: GeneralTextStyles.menuTittle,
          ),
          SizedBox(
            height: 5,
          ),
          listMovies(context,moviesPlaying)
        ],
      ),
    );
  }

  Widget listMovies(BuildContext context, List<Movie> movies) {
    return  MovieSlider(
      movies: movies,

    );
  }
}

import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/Favorite/data/favorite_db_helper.dart';
import 'package:movies_app/Fetchers/Home/Repo/Movie_Model.dart';
import 'package:movies_app/Fetchers/Movie_details/repo/MovieDetails_model.dart';
import 'package:movies_app/Fetchers/Movie_details/repo/Movie_details_API_Services.dart';
import 'package:movies_app/Fetchers/Movie_details/widget/YoutubePlayer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<MovieDetailsModel> movieRseponseFuture;
  late List<Movie> futureFav;
  late YoutubePlayerController controller;
  int _selectedButtonIndex = 0;
  bool isFav=false;

  void checkIsFav()async{
    futureFav = await FavoriteDatabaseHelper().getFavoriteMovies();
    futureFav.forEach((m) {
      setState(() {
        if(m.id == widget.movie.id){
          isFav = true;
          return;
        }
        isFav = false;
      }); 
    });
  }
  @override
  void initState() {
    super.initState();
    movieRseponseFuture = MoviesDetailsAPIServices().fetchMovieDetails(widget.movie.id!);
    // fix controller error
    // it not define but work
    controller = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
      ),
    );
    
    checkIsFav();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Details'),
      actions: [
        IconButton(onPressed: (){
          setState(() {
            if(isFav){
              FavoriteDatabaseHelper().deleteMovie(widget.movie.id!);
            }
            else {
              FavoriteDatabaseHelper().insertMovie(widget.movie);
            }
            isFav = !isFav;
          });
        }, icon: Icon(isFav? Icons.favorite : Icons.favorite_border ,color: isFav? Colors.red : Colors.grey[400],)),
      ],
    ),
    body: FutureBuilder<MovieDetailsModel>(
      future: movieRseponseFuture,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        else if(snapshot.hasData) {
          final movie = snapshot.data!;
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9, 
                      child: CustomYoutubePlayer(controller: controller, vedioId: movie.trailer_youtube_id!),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      movie.title!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [  
                        RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.calendar_month, size: 18),
                              ),
                              TextSpan(
                                text: " ${movie.year}",
                                style: const TextStyle(color: Colors.black ,fontSize: 16 ,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ) , 
                        RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(Icons.star_border_purple500, size: 18,color: Colors.amber,),
                              ),
                              TextSpan(
                                text: " ${movie.rating}",
                                style: const TextStyle(color: Colors.black ,fontSize: 16 ,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ) , 
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedButtonIndex = 0;
                            });
                          },
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: _selectedButtonIndex == 0? Colors.black87 : Colors.grey[600],
                              fontWeight: _selectedButtonIndex == 0? FontWeight.bold : FontWeight.w400,
                              decoration: _selectedButtonIndex == 0? TextDecoration.underline : TextDecoration.none,
                              decorationColor: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedButtonIndex = 1;
                            });
                          },
                          child: Text(
                            'Genre',
                            style: TextStyle(
                              fontSize: 16,
                              color: _selectedButtonIndex == 1? Colors.black87 : Colors.grey[600],
                              fontWeight: _selectedButtonIndex == 1? FontWeight.bold : FontWeight.w400,
                              decoration: _selectedButtonIndex == 1? TextDecoration.underline : TextDecoration.none,
                              decorationColor: Colors.black87
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedButtonIndex = 2;
                            });
                          },
                          child: Text(
                            'Writers',
                            style: TextStyle(
                              fontSize: 16,
                              color: _selectedButtonIndex == 2? Colors.black87 : Colors.grey[600],
                              fontWeight: _selectedButtonIndex == 2? FontWeight.bold : FontWeight.w400,
                              decoration: _selectedButtonIndex == 2? TextDecoration.underline : TextDecoration.none,
                              decorationColor: Colors.black87
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: _selectedButtonIndex == 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${movie.description}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _selectedButtonIndex == 1,
                      child: _info(movie.genre!)
                    ),
                    Visibility(
                      visible: _selectedButtonIndex == 2,
                      child: _info(movie.writers!),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}
Widget _info(List<String> data){
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data[index],
            style: const TextStyle(color: Colors.black ,fontSize: 16 ,fontWeight: FontWeight.w500),
          ),
        );
      }),
    ),
  );
}

}
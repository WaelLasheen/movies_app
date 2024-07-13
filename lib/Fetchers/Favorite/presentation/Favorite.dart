import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/Favorite/data/favorite_db_helper.dart';
import 'package:movies_app/Fetchers/Home/Repo/Movie_Model.dart';
import 'package:movies_app/core/widget/Build_gridview.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late Future<List<Movie>> futureFavoriteMovies;
  @override
  void initState() {
    super.initState();
    futureFavoriteMovies = FavoriteDatabaseHelper().getFavoriteMovies();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureFavoriteMovies,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasError){
          throw("Error in fetch database's data : ${snapshot.error}" );
        }
        if(snapshot.hasData){
          print(snapshot.data!.length);
          return BuildGridView(movies: snapshot.data!);
        }
        return const Center( child: CircularProgressIndicator(),);
      },
    );
  }
}
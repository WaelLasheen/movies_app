
import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/Home/Repo/Movies_API_Services.dart';
import 'package:movies_app/Fetchers/Home/Repo/Movie_Model.dart';
import 'package:movies_app/Fetchers/Home/data/search.dart';
import 'package:movies_app/core/widget/Build_gridview.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> moviesRseponseFuture;
  List<Movie> movieList=[];


  @override
  void initState() {
    super.initState();
    moviesRseponseFuture = MoviesAPIServices().fetchMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100
          ),
          child: Row(
            children: [
              const Text('Top movies',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              const Spacer(),
              IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: DataSearch(movies: movieList)),
                icon: const Icon(Icons.search)),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.width* .155-80,
          child: FutureBuilder<List<Movie>>(
            future:moviesRseponseFuture,
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              else if(snapshot.hasData) {
                movieList=snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BuildGridView(movies: snapshot.data!),
                );
              }
              else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
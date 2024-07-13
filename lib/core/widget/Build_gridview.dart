import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/Home/Repo/Movie_Model.dart';
import 'package:movies_app/core/widget/MovieCard.dart';

class BuildGridView extends StatefulWidget {
  final List<Movie> movies;
  const BuildGridView({required this.movies});

  @override
  State<BuildGridView> createState() => _BuildGridViewState();
}

class _BuildGridViewState extends State<BuildGridView> {
  @override
  Widget build(BuildContext context) {
    List<Movie> movies = widget.movies;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
        childAspectRatio: 0.6,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: movies[index]);
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/Home/Repo/Movie_Model.dart';
import 'package:movies_app/Fetchers/Movie_details/presentation/movieDetails.dart';
import 'package:movies_app/core/widget/Build_gridview.dart';

class DataSearch extends SearchDelegate<String> {
  List<Movie> movies = [];
  late List<Movie> filter=[];
  DataSearch({required this.movies});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, ''),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if(filter.isEmpty) {
      return Center(child: Image.network('https://cdn.dribbble.com/userupload/8392917/file/original-12975f538c2c84c598f256f075ffde7a.jpg?resize=752x'),);
    }
    return BuildGridView(movies: filter);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') return const Text('');
    filter = movies
        .where((product) =>
            product.title!.toUpperCase().contains(query.toUpperCase()))
        .toList();
    // iteams = filter;

    if (filter.isEmpty) {
      return Center(
          child: Image.network(
              'https://cdn.dribbble.com/userupload/8392916/file/original-eacb85dbe2edcca45e0ccfeecfcbc012.jpg?resize=1024x769'));
    }

    return ListView.builder(
        itemCount: filter.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // query = filter[index].title!;
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(movie: filter[index]),));
            },
            child: ListTile(
              title: Text(
                filter[index].title!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              trailing:
                  SizedBox(width: 30, child: Image.network(filter[index].image!)),
            ),
          );
        });
  }
}

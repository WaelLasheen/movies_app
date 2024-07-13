import 'dart:convert';

import 'package:movies_app/Fetchers/Home/Repo/Movie_Model.dart';
import 'package:http/http.dart' as http;
class MoviesAPIServices{

  Future<List<Movie>> fetchMovies() async{
    const String URL="https://imdb-top-100-movies.p.rapidapi.com/";
    const Map<String,String> headers={
      'X-RapidAPI-Key': '3f4b19e624msh8e1a2e1f8743737p1bd1bejsnc9127f00fbcc',
      'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
    };
    try{
      print('not');
      final response = await http.get(Uri.parse(URL),headers: headers);
      print('done');
      if(response.statusCode==200){
        List data = jsonDecode(response.body);
        print('1');
        List<Movie> movies=[];
        data.forEach((e){movies.add(Movie.fromJson(e));});
        print('2');
        return movies;
      }
      else{
        throw Exception('Failed to fetch data from API. Status code: ${response.statusCode}');
      }
    }
    catch(e){
      throw Exception('Failed to fetch data from API. Error: $e');

    }
  }
}
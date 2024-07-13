import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/Fetchers/Movie_details/repo/MovieDetails_model.dart';
class MoviesDetailsAPIServices{

  Future<MovieDetailsModel> fetchMovieDetails(String id) async{
    String URL="https://imdb-top-100-movies.p.rapidapi.com/${id}";
    const Map<String,String> headers={
      'X-RapidAPI-Key': '3f4b19e624msh8e1a2e1f8743737p1bd1bejsnc9127f00fbcc',
      'X-RapidAPI-Host': 'imdb-top-100-movies.p.rapidapi.com'
    };
    try{
      print('not');
      final response = await http.get(Uri.parse(URL),headers: headers);
      print('done');
      if(response.statusCode==200){
        final data = jsonDecode(response.body);
        print('done1');
        return MovieDetailsModel.fromJson(data);
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
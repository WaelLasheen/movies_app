class Movie{
  int? rank;
  String? title;
  String? description;
  String? image;
  List<String>? genre;
  String? rating;
  String? id;
  int? year;

  Movie({this.rank,this.title,this.description,this.image,this.genre,this.rating,this.id,this.year});

  Movie.fromJson(Map<String,dynamic>Json){
    rank = Json['rank'];
    title = Json['title'];
    description = Json['description'];
    image = Json['image'];
    genre = List<String>.from(Json['genre'] as List<dynamic>);
    rating = Json['rating'];
    id = Json['id'];
    year = Json['year'];
  }
 
  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'title': title,
      'description': description,
      'image': image,
      'genre': genre!.join(','),
      'rating': rating,
      'id': id,
      'year': year,
    };
  }
}
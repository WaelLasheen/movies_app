class MovieDetailsModel {
  int? rank;
  String? title;
  String? rating;
  String? id;
  int? year;
  String? image;
  String? description;
  String? trailer_youtube_id;
  List<String>? genre;
  List<String>? director;
  List<String>? writers;

  MovieDetailsModel(
      {this.rank,
      this.title,
      this.rating,
      this.id,
      this.year,
      this.image,
      this.description,
      this.trailer_youtube_id,
      this.genre,
      this.director,
      this.writers,
    });

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    title = json['title'];
    rating = json['rating'];
    id = json['id'];
    year = json['year'];
    image = json['image'];
    description = json['description'];
    trailer_youtube_id = json['trailer_youtube_id'];
    genre = json['genre'].cast<String>();
    director = json['director'].cast<String>();
    writers = json['writers'].cast<String>();
  }
}
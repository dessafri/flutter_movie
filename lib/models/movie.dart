import 'package:hive/hive.dart';
part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  int id;
  @HiveField(1)
  String imageUrl;
  @HiveField(2)
  String title;
  @HiveField(3)
  String overview;
  @HiveField(4)
  String backdrop;
  @HiveField(5)
  String rilis;
  @HiveField(6)
  int rating;

  Movie(
      {this.id,
      this.imageUrl,
      this.title,
      this.backdrop,
      this.overview,
      this.rilis,
      this.rating});

  factory Movie.fromJson(json) {
    return new Movie(
      id: json["id"],
      imageUrl: json["poster_path"],
      title: json["title"],
      // category: json["genre_ids"],
      overview: json["overview"],
      backdrop: json["backdrop_path"],
      rilis: json["release_date"],
      rating: json["vote_average"].toInt(),
    );
  }
}

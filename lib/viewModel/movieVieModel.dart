import 'package:hive/hive.dart';
import 'package:movieku/models/movie.dart';

class MovieViewModel {
  static final moviebox = Hive.box("movie");

  static Future openBox() {
    return Hive.openBox("movie");
  }

  static void add(Movie movie) {
    moviebox.put(movie.id, movie);
  }

  static Box<dynamic> getAll() {
    return moviebox;
  }

  static void delete(int index) {
    moviebox.delete(index);
  }

  static getAt(int index) {
    return moviebox.getAt(index);
  }
}

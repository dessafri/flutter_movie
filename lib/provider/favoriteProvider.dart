import 'package:flutter/cupertino.dart';

class FavoriteMovie with ChangeNotifier {
  bool fav = false;

  bool get isFavorite => fav;

  set isFavorite(bool value) {
    fav = value;
    notifyListeners();
  }
}

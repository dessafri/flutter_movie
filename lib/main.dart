import 'package:flutter/material.dart';
import 'package:movieku/models/movie.dart';
import 'package:movieku/pages/home.dart';
import 'package:movieku/provider/coomingsoonProvider.dart';
import 'package:movieku/provider/favoriteProvider.dart';
import 'package:movieku/provider/toprateProvider.dart';
import 'package:movieku/provider/topmovieProvider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocument = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocument.path);
  Hive.registerAdapter(MovieAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopMovieProvider>(
            create: (context) => TopMovieProvider()),
        ChangeNotifierProvider<LastestMovieProvider>(
            create: (context) => LastestMovieProvider()),
        ChangeNotifierProvider<CoomingsoonProvider>(
            create: (context) => CoomingsoonProvider()),
        ChangeNotifierProvider<FavoriteMovie>(
            create: (context) => FavoriteMovie()),
      ],
      child: Container(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      )),
    );
  }
}

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieku/models/movie.dart';
import 'package:movieku/provider/favoriteProvider.dart';
import 'package:movieku/routes/route.dart';
import 'package:movieku/theme.dart';
import 'package:movieku/viewModel/movieVieModel.dart';
import 'package:movieku/widget/widget_action.dart';
import 'package:movieku/widget/widget_buttonFav.dart';
import 'package:movieku/widget/widget_movie.dart';
import 'package:movieku/widget/widget_rating.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(MaterialApp(
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}

class Detail extends StatefulWidget {
  final Movie movie;

  Detail(this.movie);
  DetailPage createState() => DetailPage(movie);
}

class DetailPage extends State<Detail> {
  final Movie movie;

  Future<List<Movie>> _fetchDataMovie() async {
    final response = await http.get(
        'https://api.themoviedb.org/3/movie/${movie.id}/similar?api_key=5098a9e3ca4920eb139726beda7dbdf6&language=en-US&page=1');
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['results'];
      List list = result;
      return list.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception("Movie Tidak Tampil");
    }
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  DetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                color: blackColor,
                height: 440,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://image.tmdb.org/t/p/original/${movie.imageUrl}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )),
            Container(
                height: 440,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          whiteColor.withOpacity(1)
                        ],
                        stops: [
                          0.0,
                          1.0
                        ]))),
            ListView(
              children: [
                SizedBox(
                  height: 440,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36),
                          topRight: Radius.circular(36))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        movie.title,
                        style: blackStyle.copyWith(fontSize: 30),
                      ),
                      Text(
                        movie.rilis,
                        style: greyStyle.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [1, 2, 3, 4, 5].map((e) {
                          return Container(
                            child: Rating(
                              index: e,
                              rating: movie.rating,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                launchURL(
                                    'https:www.youtube.com/results?search_query=${movie.title}');
                              },
                              child: ButtonAction(
                                  imageUrl: "assets/btn_play.png")),
                          SizedBox(
                            width: 15,
                          ),
                          FutureBuilder(
                            future: MovieViewModel.openBox(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Container(
                                    // ignore: deprecated_member_use
                                    child: WatchBoxBuilder(
                                        box: MovieViewModel.getAll(),
                                        builder: (context, moviebox) {
                                          var cek = 0;
                                          moviebox.values
                                              .where((element) =>
                                                  element.id == movie.id)
                                              .forEach((element) {
                                            print(element);
                                            cek = 1;
                                          });
                                          if (cek == 1) {
                                            return InkWell(
                                                onTap: () {
                                                  Flushbar(
                                                    margin: EdgeInsets.all(10),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    borderRadius: 8,
                                                    backgroundColor:
                                                        Colors.green,
                                                    padding: EdgeInsets.all(10),
                                                    messageText: Text(
                                                      "SUCCESS DELETE MOVIE FROM FAVORITE !",
                                                      style:
                                                          whiteStyle.copyWith(
                                                              fontSize: 15),
                                                    ),
                                                    icon: Icon(
                                                      EvaIcons
                                                          .checkmarkCircle2Outline,
                                                      size: 28.0,
                                                      color: Colors.black,
                                                    ),
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ).show(context);
                                                  MovieViewModel.delete(
                                                      movie.id);
                                                },
                                                child: ButtonAction(
                                                    imageUrl:
                                                        "assets/btn_fav_on.png"));
                                          } else {
                                            return InkWell(
                                                onTap: () {
                                                  Flushbar(
                                                    margin: EdgeInsets.all(10),
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    borderRadius: 8,
                                                    backgroundColor:
                                                        Colors.green,
                                                    padding: EdgeInsets.all(10),
                                                    messageText: Text(
                                                      "SUCCESS ADD MOVIE TO FAVORITE !",
                                                      style:
                                                          whiteStyle.copyWith(
                                                              fontSize: 15),
                                                    ),
                                                    icon: Icon(
                                                      EvaIcons
                                                          .checkmarkCircle2Outline,
                                                      size: 28.0,
                                                      color: Colors.black,
                                                    ),
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ).show(context);
                                                  MovieViewModel.add(movie);
                                                },
                                                child: ButtonAction(
                                                    imageUrl:
                                                        "assets/btn_fav.png"));
                                          }
                                        }),
                                  );
                                } else {
                                  return Text("Conection Loading");
                                }
                              } else {
                                return Text("Conection Loading");
                              }
                            },
                          ),
                          // ignore: deprecated_member_use
                          // WatchBoxBuilder(
                          //     box: MovieViewModel.getAll(),
                          //     builder: (context, moviebox) {
                          //       ListView.builder(
                          //           itemCount: moviebox.length,
                          //           itemBuilder: (context, index) {
                          //             final movies =
                          //                 MovieViewModel.getAt(index);
                          //             ButtonFav(
                          //               movie: movie,
                          //               movies: movies,
                          //               index: index,
                          //             );
                          //           });
                          //     })
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: blackStyle.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width - (2 * 30),
                              child: Text(
                                movie.overview,
                                style: blackStyle,
                                textAlign: TextAlign.start,
                                maxLines: 4,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Recommendation",
                              style: blackStyle.copyWith(fontSize: 20),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            FutureBuilder(
                              future: _fetchDataMovie(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  List<Movie> data = snapshot.data;
                                  int index = 0;
                                  return Container(
                                    height: 250,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: data.map((e) {
                                        index++;
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: index == 1 ? 0 : 10),
                                          child: MovieCard(e),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: whiteColor,
              ),
              child: Icon(
                Icons.chevron_left,
                size: 30,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieku/models/movie.dart';
import 'package:movieku/pages/favorite.dart';
import 'package:movieku/provider/coomingsoonProvider.dart';
import 'package:movieku/provider/toprateProvider.dart';
import 'package:movieku/provider/topmovieProvider.dart';
import 'package:movieku/widget/widget_button.dart';
import 'package:movieku/widget/widget_coomingsoon.dart';
import 'package:movieku/widget/widget_movie.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var topMovieProvider = Provider.of<TopMovieProvider>(context);
    var toprateProvider = Provider.of<LastestMovieProvider>(context);
    var coomingsoonProvider = Provider.of<CoomingsoonProvider>(context);
    topMovieProvider.getTopmovie();
    toprateProvider.getTopRatemovie();
    coomingsoonProvider.getUpcomingMovie();
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "MovieKu",
                    style: blackStyle.copyWith(fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Cooming Soon",
                    style: blackStyle.copyWith(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FutureBuilder(
                  future: coomingsoonProvider.getUpcomingMovie(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Movie> data = snapshot.data;
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 280.0,
                          autoPlay: true,
                        ),
                        items: data.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: CoomingsoonCard(i));
                            },
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Top Movies",
                    style: blackStyle.copyWith(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FutureBuilder(
                  future: topMovieProvider.getTopmovie(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              margin:
                                  EdgeInsets.only(left: index == 1 ? 30 : 10),
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
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Lastest Movies",
                    style: blackStyle.copyWith(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FutureBuilder(
                  future: toprateProvider.getTopRatemovie(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              margin:
                                  EdgeInsets.only(left: index == 1 ? 30 : 10),
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
                  height: 70,
                )
              ],
            ),
          ],
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30),
          height: 50,
          width: MediaQuery.of(context).size.width - (2 * 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23), color: whiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 65,
                width: MediaQuery.of(context).size.width - (2 * 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Button(
                      icon: "assets/icon_home.png",
                      name: "Home",
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Favorite()));
                      },
                      child: Button(
                        icon: "assets/icon_fav.png",
                        name: "Favorite",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

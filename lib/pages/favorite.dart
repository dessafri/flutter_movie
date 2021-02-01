import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieku/models/movie.dart';
import 'package:movieku/theme.dart';
import 'package:movieku/viewModel/movieVieModel.dart';
import 'package:movieku/widget/widget_button.dart';
import 'package:movieku/widget/widget_favorite.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "My Favorite Movie",
                  style: blackStyle.copyWith(fontSize: 20),
                ),
              ),
              FutureBuilder(
                future: MovieViewModel.openBox(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Container(
                        // ignore: deprecated_member_use
                        child: WatchBoxBuilder(
                            box: MovieViewModel.getAll(),
                            builder: (context, moviebox) {
                              return Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: ListView.builder(
                                  itemCount: moviebox.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final movie = MovieViewModel.getAt(index);
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                (2 * 30),
                                        child: Column(children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          FavoriteCard(movie)
                                        ]));
                                  },
                                ),
                              ));
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
            ],
          ),
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
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Button(
                        icon: "assets/icon_home.png",
                        name: "Home",
                      ),
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

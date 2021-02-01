import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movieku/models/movie.dart';
import 'package:movieku/pages/detail.dart';
import 'package:movieku/theme.dart';
import 'package:movieku/viewModel/movieVieModel.dart';

// ignore: must_be_immutable
class FavoriteCard extends StatelessWidget {
  Movie movie;

  FavoriteCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Detail(movie))),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width - (2 * 30),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.5),
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: 'http://image.tmdb.org/t/p/original/${movie.imageUrl}',
              width: 75,
              height: 75,
              fit: BoxFit.fitHeight,
            ),
            Text(
              movie.title,
              style: blackStyle.copyWith(
                fontSize: 16,
              ),
              maxLines: 2,
            ),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: InkWell(
                onTap: () {
                  Flushbar(
                    margin: EdgeInsets.all(10),
                    flushbarPosition: FlushbarPosition.TOP,
                    borderRadius: 8,
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.all(10),
                    messageText: Text(
                      "SUCCESS DELETE FAVORITE MOVIE !",
                      style: whiteStyle.copyWith(fontSize: 15),
                    ),
                    icon: Icon(
                      EvaIcons.checkmarkCircle2Outline,
                      size: 28.0,
                      color: Colors.black,
                    ),
                    duration: Duration(seconds: 3),
                  ).show(context);
                  MovieViewModel.delete(movie.id);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 26,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

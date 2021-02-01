import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieku/models/movie.dart';
import 'package:movieku/pages/detail.dart';
import 'package:movieku/theme.dart';

class CoomingsoonCard extends StatelessWidget {
  @override
  final Movie movie;

  CoomingsoonCard(this.movie);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Detail(movie))),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // child: Image.network(
                //   "http://image.tmdb.org/t/p/original/${movie.backdrop}",
                //   width: 378,
                //   height: 180,
                // ),
                child: CachedNetworkImage(
                    imageUrl:
                        "http://image.tmdb.org/t/p/original/${movie.backdrop}",
                    placeholder: (context, url) => Container(
                          child: Center(child: new CircularProgressIndicator()),
                        ),
                    height: 180,
                    width: 378)),
            SizedBox(
              height: 6,
            ),
            Text(
              movie.title,
              style: blackStyle.copyWith(fontSize: 20),
            ),
            Text(
              movie.rilis,
              style: greyStyle.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

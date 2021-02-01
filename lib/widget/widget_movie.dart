import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieku/models/movie.dart';
import 'package:movieku/pages/detail.dart';
import 'package:movieku/theme.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Detail(movie))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                child: Container(
              width: 120,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          'http://image.tmdb.org/t/p/original/${movie.imageUrl}',
                      width: 120,
                      height: 190,
                      fit: BoxFit.cover,
                      placeholder: _loader,
                      errorWidget: _error,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    movie.title,
                    style: blackStyle.copyWith(fontSize: 16),
                    maxLines: 2,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _loader(BuildContext context, String url) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return Center(
      child: Icon(Icons.error_outline),
    );
  }
}

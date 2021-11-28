// ignore_for_file: unnecessary_string_interpolations, duplicate_ignore

import 'package:bincard/model/movie.dart';
import 'package:flutter/material.dart';

class MovieDetailCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailCast({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Director", value: movie.director),
          MovieField(field: "Award", value: movie.awards)
        ],
      ),
    );
  }
}

class MovieDetailThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailThumbnail({Key? key, required this.thumbnail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover)),
            ),
            const Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          height: 80,
        )
      ],
    );
  }
}

class MovieDetailHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailHeaderWithPoster({Key? key, required this.movie})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0].toString()),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: MovieDetailHeader(movie: movie),
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key? key, required this.poster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class MovieDetailHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailHeader({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} .${movie.genre}".toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.w400, color: Colors.indigoAccent),
        ),
        Text(
          // ignore: unnecessary_string_interpolations
          "${movie.title}",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        Text.rich(TextSpan(
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            children: <TextSpan>[
              TextSpan(text: movie.plot),
              const TextSpan(text: "more...")
            ]))
      ],
    );
  }
}

class MovieField extends StatelessWidget {
  final String field, value;

  const MovieField({Key? key, required this.field, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field",
          style: const TextStyle(
              color: Colors.black45, fontSize: 12, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Text(
            "$value",
            style: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailExtraPoster extends StatelessWidget {
  final List<String> poster;

  const MovieDetailExtraPoster({Key? key, required this.poster})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Text(
            "More movie Poster".toUpperCase(),
            style: const TextStyle(fontSize: 14, color: Colors.black26),
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 5),
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 8.0,
              ),
              itemCount: poster.length,
              itemBuilder: (context, index) => ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(poster[index]),
                            fit: BoxFit.cover)),
                  )),
            )),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/models/movie.dart';
import 'package:testing/screens/details_screen.dart';
import '../constants.dart';

class CustomCardNormal extends StatelessWidget {
  final Movie movie;

  const CustomCardNormal({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailsScreen()),
        );
      },
      child: Column(
        children: [
          Container(
            height: 150,
            width: 250,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image:
                NetworkImage('${Constanst.imagePath}${movie.backDropPath}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            movie.title,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              Text(
                movie.releaseDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 100,),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "/10",
                    style: const TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

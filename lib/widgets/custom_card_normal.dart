import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/models/movie.dart';
import 'package:testing/screens/details_screen.dart';
import '../api/constants.dart';

class CustomCardNormal extends StatelessWidget {
  final Movie movie;

  const CustomCardNormal({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(
                movie: movie,
              )),
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
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: Text(
                  movie.releaseDate.split("-").first,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.redAccent,
                  ),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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

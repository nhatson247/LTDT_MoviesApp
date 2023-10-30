import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/data/movie.dart';
import 'package:testing/screens/details_screen.dart';

class CustomCardNormal extends StatelessWidget {
  MovieModel movieModel;

  CustomCardNormal({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DetailsScreen())
        );
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 140,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(movieModel.imageAsset!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        movieModel.movieName!,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        movieModel.year!,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white38,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieModel.movieRating!,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

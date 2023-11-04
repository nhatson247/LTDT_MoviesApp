import 'package:flutter/material.dart';
import 'package:testing/api/constants.dart';
import 'package:testing/models/movie.dart';

import '../screens/details_screen.dart';

class CustomCardTrending extends StatelessWidget {
  final Movie movie;

  const CustomCardTrending({super.key, required this.movie});

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              '${Constanst.imagePath}${movie.posterPath}',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.50,
            ),
            Positioned(
              bottom: 0,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

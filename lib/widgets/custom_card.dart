import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/Movies/details_screen.dart';

import '../api/constants.dart';
import '../models/movie.dart';

class CustomCard extends StatelessWidget {
  final Movie movie;
  CustomCard({super.key,required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(movie: movie,)),
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
        ],
      ),
    );
  }
}

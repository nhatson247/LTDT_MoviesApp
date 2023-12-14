import 'package:flutter/material.dart';
import 'package:testing/api/constants.dart';

import '../models/cast.dart';

class CastAndCrewWidget extends StatelessWidget {
  final List<Cast> casts;

  const CastAndCrewWidget({super.key, required this.casts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Casts",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
                itemCount: casts.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return castCard(casts[index]);
                }),
          )
        ],
      ),
    );
  }

  Widget castCard(Cast cast) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 70,
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: cast.profilePath != null
                    ? NetworkImage('${Constanst.imagePath}${cast.profilePath}')
                    : AssetImage('cast.jpg') as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            cast.name,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:testing/api/api.dart';
import 'package:testing/models/People.dart';
import 'package:testing/utils/colors.dart';
import 'package:readmore/readmore.dart';
import 'package:testing/widgets/cast_and_crew.dart';

import '../api/constants.dart';
import '../models/movie.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<List<People>> popularItems;

  @override
  void initState() {
    super.initState();
    popularItems = Api().getPeopleMovie();
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = widget.movie;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        '${Constanst.imagePath}${movie.backDropPath}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.play_circle_outline,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Watch Movie",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
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
                ),
                // Mô tả
                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Row(
                    children: [
                      Text(
                        "Overview",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: ReadMoreText(
                    movie.overview,
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Đoạn này sử dụng popularItems sau khi Future hoàn thành
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder<List<People>>(
                    future: popularItems,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return CastAndCrewWidget(casts: snapshot.data!);
                        } else {
                          return Text("Error loading cast data");
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

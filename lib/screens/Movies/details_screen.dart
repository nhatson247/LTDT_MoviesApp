import 'package:flutter/material.dart';
import 'package:testing/api/api.dart';
import 'package:testing/homepage.dart';
import 'package:testing/models/cast.dart';
import 'package:testing/models/review.dart';
import 'package:testing/utils/colors.dart';
import 'package:readmore/readmore.dart';
import 'package:testing/widgets/Movie_Section.dart';
import 'package:testing/widgets/cast_and_crew.dart';
import 'package:testing/widgets/reviews_and_crew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/constants.dart';
import '../../models/movie.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<List<Cast>> castItems;
  late Future<List<Review>> reviewItems;
  late Future<List<Movie>> relatedMovies;
  late bool isFavorite;
  String? videoKey;

  @override
  void initState() {
    super.initState();
    castItems = Api().getMovieCast(widget.movie.id);
    reviewItems = Api().getMovieReview(widget.movie.id);
    relatedMovies = Api().getRelatedMovies(widget.movie.id);
    isFavorite = false;
    checkFavoriteStatus();
    loadVideoKey();
  }

  void loadVideoKey() async {
    try {
      final key = await Api().getMovieVideo(widget.movie.id);
      setState(() {
        videoKey = key;
      });
    } catch (e) {
      print("Error loading video key: $e");
    }
  }

  void _openYoutubeVideo(String videoKey) {
    final youtubeUrl = "https://www.youtube.com/watch?v=$videoKey";
    launchUrl(Uri.parse(youtubeUrl));
  }

  void checkFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<int> favoriteMovies =
        prefs.getStringList('favorites')?.map((id) => int.parse(id)).toSet() ??
            Set<int>();
    setState(() {
      isFavorite = favoriteMovies.contains(widget.movie.id);
    });
  }

  void toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
    });

    Set<int> favoriteMovies = prefs.getStringList('favorites')?.map((id) => int.parse(id)).toSet() ??
            Set<int>();
    if (isFavorite) {
      favoriteMovies.add(widget.movie.id);
    } else {
      favoriteMovies.remove(widget.movie.id);
    }
    prefs.setStringList(
        'favorites', favoriteMovies.map((id) => id.toString()).toList());
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
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: kSearchbarColor,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    toggleFavorite();
                  },
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(3),
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
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red,
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (videoKey != null) {
                                                _openYoutubeVideo(videoKey!);
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: ReadMoreText(
                    movie.overview,
                    colorClickableText: Colors.redAccent,
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: FutureBuilder<List<Cast>>(
                    future: castItems,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return CastAndCrewWidget(casts: snapshot.data!);
                        } else {
                          return Text(
                              "Error loading cast data ${snapshot.error}");
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Row(
                    children: [
                      Text(
                        "Reviews",
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FutureBuilder<List<Review>>(
                    future: reviewItems,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ReviewCard(reviews: snapshot.data!);
                        } else {
                          return Text(
                              "Error loading Revies data ${snapshot.error}");
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Row(
                    children: [
                      Text(
                        "Related Movies",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                RelatedMoviesSection(relatedMovies: relatedMovies),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

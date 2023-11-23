import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/api/api.dart';
import 'package:testing/api/constants.dart';

import '../../models/movie.dart';
import '../../utils/colors.dart';
import '../Movies/details_screen.dart';

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<Movie> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteMovies();
  }

  void loadFavoriteMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteMoviesString = prefs.getStringList('favorites');
    if (favoriteMoviesString != null) {
      List<int> favoriteMovieIds =
      favoriteMoviesString.map((id) => int.parse(id)).toList();

      List<Movie> movies = await Future.wait(
        favoriteMovieIds.map((id) => Api().getMovieDetails(id)),
      );

      setState(() {
        favoriteMovies = movies;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text("WatchList"),
      ),
      body: Container(
        color: kBackgroundColor,
        child: favoriteMovies.isEmpty
            ? Center(
          child: Text("Favorites list is empty"),
        )
            : ListView.builder(
          itemCount: favoriteMovies.length,
          itemBuilder: (context, index) {
            Movie movie = favoriteMovies[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      movie: movie,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: kColorDF,
                  child: buildMovieContainer(movie),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildMovieContainer(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kColorDF,
        child: Row(
          children: [
            Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      '${Constanst.imagePath}${movie.backDropPath}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

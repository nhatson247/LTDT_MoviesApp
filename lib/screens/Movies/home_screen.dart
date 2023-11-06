import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:testing/utils/colors.dart';
import 'package:testing/widgets/custom_card_normal.dart';
import '../../api/api.dart';
import '../../models/movie.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_card_trending.dart';
import 'movie_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrengdingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpComingMovies();
  }

  int currentPage = 0;

  List tabBarIcons = [
    Icons.home,
    Icons.play_circle_outline,
    Icons.bookmark,
    Icons.person,
  ];

  List<Widget> pageControllerWidget() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white30,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hi, Sơn!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: AssetImage("avt_account.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                height: 10,
                                width: 10,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Tìm kiếm",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black26,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      "Trending Movies",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<Movie>>(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return TrendingCardsLayout(snapshot);
                      } else {
                        return const Center(
                          child: Text("No data available"),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: pageControllerWidget(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Top Rated Movies",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieListScreen(movies: topRatedMovies, title: "Top Rated Movie" ),
                                  ),
                                );
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  FutureBuilder<List<Movie>>(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MovieListTopRated(snapshot);
                      } else {
                        return const Center(
                          child: Text("No data available"),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Upcoming Movies",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieListScreen(movies: upcomingMovies, title: "Upcoming Movies" ),
                                  ),
                                );
                              },
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  color: Colors.yellow[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  FutureBuilder<List<Movie>>(
                    future: upcomingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MovieListUpcoming(snapshot);
                      } else {
                        return const Center(
                          child: Text("No data available"),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TrendingCardsLayout(AsyncSnapshot<List<Movie>> snapshot) {
    final List<Movie> trendingMovies = snapshot.data ?? [];
    final limitedMovies = trendingMovies.take(5).toList();
    return SizedBox(
      child: CarouselSlider.builder(
        itemCount: limitedMovies.length,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.55,
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          onPageChanged: (int page, reason) {
            setState(() {
              currentPage = page;
            });
          },
        ),
        itemBuilder: (context, index, page) {
          return CustomCardTrending(movie: snapshot.data![index]);
        },
      ),
    );
  }

  Widget MovieListTopRated(AsyncSnapshot<List<Movie>> snapshot) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data?.length ?? 0,
        itemBuilder: (context, index) {
          return CustomCardNormal(movie: snapshot.data![index]);
        },
      ),
    );
  }

  Widget MovieListUpcoming(AsyncSnapshot<List<Movie>> snapshot) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data?.length ?? 0,
        itemBuilder: (context, index) {
          return CustomCard(movie: snapshot.data![index]);
        },
      ),
    );
  }
}

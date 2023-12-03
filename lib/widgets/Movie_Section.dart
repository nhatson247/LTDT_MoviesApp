import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/movie.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_card_normal.dart';
import '../../widgets/custom_card_trending.dart';
import '../../account/login.dart';
import '../../Luu.dart';

class TrendingMoviesSection extends StatefulWidget {
  final Future<List<Movie>> trendingMovies;
  final ValueChanged<int> onPageChanged; // Thêm dòng này

  const TrendingMoviesSection({Key? key, required this.trendingMovies, required this.onPageChanged})
      : super(key: key);

  @override
  State<TrendingMoviesSection> createState() => _TrendingMoviesSectionState();
}

class _TrendingMoviesSectionState extends State<TrendingMoviesSection> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: widget.trendingMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return TrendingCardsLayout(context, snapshot);
          } else {
            return Text("Error loading trending data ${snapshot.error}");
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget TrendingCardsLayout(BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
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
            widget.onPageChanged(currentPage);
          },
        ),
        itemBuilder: (context, index, page) {
          return CustomCardTrending(movie: snapshot.data![index]);
        },
      ),
    );
  }
}

class TopRatedMoviesSection extends StatelessWidget {
  final Future<List<Movie>> topRatedMovies;

  const TopRatedMoviesSection({Key? key, required this.topRatedMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: topRatedMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return MovieListTopRated(context,snapshot);
          } else {
            return Text("Error loading top rated data ${snapshot.error}");
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget MovieListTopRated(BuildContext context,AsyncSnapshot<List<Movie>> snapshot) {
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
}

class UpcomingMoviesSection extends StatelessWidget {
  final Future<List<Movie>> upcomingMovies;

  const UpcomingMoviesSection({Key? key, required this.upcomingMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: upcomingMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return MovieListUpcoming(context,snapshot);
          } else {
            return Text("Error loading upcoming data ${snapshot.error}");
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget MovieListUpcoming(BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
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

class UserInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (authProvider.loggedInStudent == null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("logo.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: AssetImage("cast.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ] else ...[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("logo.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${authProvider.loggedInStudent?.hoten}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _showPopupMenu(context);
                          },
                          child: Container(
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
                        ),
                      ],
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
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    final RenderBox overlay =
    Overlay.of(context).context.findRenderObject() as RenderBox;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        overlay.globalToLocal(Offset(screenWidth - 60, screenHeight * 0.1)),
        overlay.globalToLocal(
            Offset(screenWidth - 45, screenHeight * 0.7 - 30)),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(
          value: 'logout',
          child: Text(
            'Đăng xuất',
            style: TextStyle(
              color: Colors.grey[300],
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
      color: Colors.grey,
    ).then((value) {
      if (value == 'logout') {
        Provider.of<AuthProvider>(context, listen: false).logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }
}

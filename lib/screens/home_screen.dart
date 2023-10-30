import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:testing/utils/colors.dart';
import 'package:testing/data/movie.dart';
import 'package:testing/widgets/custom_card.dart';
import 'package:testing/widgets/custom_card_normal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //items
  List<MovieModel> foryouItemsList = List.of(forYouImages);
  List<MovieModel> popularItemsList = List.of(popularImages);
  List<MovieModel> genresItemsList = List.of(genresList);
  List<MovieModel> legendaryItemsList = List.of(legendaryImages);

  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.9);

  int currentPage = 0;

  List tabBarIcons = [
    Icons.home,
    Icons.ondemand_video_rounded,
    Icons.video_collection,
    Icons.account_box_outlined,
  ];

  // control của thẻ card
  List<Widget> PageControlerWidget() {
    List<Widget> list = [];
    for (int i = 0; i < foryouItemsList.length; i++) {
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          //item
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hi, Sơn!",
                          style: TextStyle(color: Colors.white, fontSize: 30),
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
                                  )),
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
                    height: 20,
                  ),
                  // phan search
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      padding: const EdgeInsets.all(20), // can 2 ben
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "Trending Movies",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  foryoucardsLayout(forYouImages),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: PageControlerWidget(),
                    ),
                  ),
                  // Nổi bật
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Nổi Bật",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Xem tất cả",
                              style: TextStyle(
                                color: Colors.white12,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  MovieListPL(popularItemsList),
                  // Trendding
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Huyền Thoại",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Xem tất cả",
                              style: TextStyle(
                                color: Colors.white12,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  MovieListGR(genresItemsList),
                  //Huyền thoại
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Hành động",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Xem tất cả",
                              style: TextStyle(
                                color: Colors.white12,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  MovieListPL(legendaryItemsList),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 30,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 25.0,
                  sigmaY: 25.0,
                ),
                child: Container(
                  color: kSearchbarColor.withOpacity(0.9),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...tabBarIcons.map((e) => Icon(
                            e,
                            color:
                                e == Icons.home ? Colors.white : Colors.white54,
                            size: 25,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // thẻ card
  // Widget foryoucardsLayout(List<MovieModel> movieList) {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.60,
  //     child: PageView.builder(
  //       physics: const ClampingScrollPhysics(),
  //       controller: pageController,
  //       itemCount: movieList.length,
  //       itemBuilder: (context, index) {
  //         return CustomCard(imageAsset: movieList[index].imageAsset.toString());
  //       },
  //       onPageChanged: (int page) {
  //         setState(() {
  //           currentPage = page;
  //         });
  //       },
  //     ),
  //   );
  // }

  Widget foryoucardsLayout(List<MovieModel> movieList) {
    return SizedBox(
      child: CarouselSlider.builder(
        itemCount: movieList.length,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.60,
            autoPlay: true,
            viewportFraction: 0.80,
            enlargeCenterPage: true,
            pageSnapping: true,
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            onPageChanged: (int page, reason) {
              setState(() {
                currentPage = page;
              });
            }),
        itemBuilder: (context, index, page) {
          return Container(
            child: CustomCard(
              imageAsset: movieList[index].imageAsset.toString(),
            ),
          );
        },
      ),
    );
  }

  Widget MovieListPL(List<MovieModel> movieList) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return CustomCardNormal(movieModel: movieList[index]);
        },
      ),
    );
  }

  Widget MovieListGR(List<MovieModel> genresList) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      height: MediaQuery.of(context).size.height * 0.30,
      child: ListView.builder(
        itemCount: genresList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                      genresList[index].imageAsset.toString(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: const EdgeInsets.only(right: 15, top: 8, bottom: 25),
              ),
              Positioned(
                left: 20,
                bottom: 0,
                child: Text(
                  genresList[index].movieName.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:testing/screens/home_screen.dart';
import 'package:testing/utils/colors.dart';
import 'package:testing/data/movie.dart';
import 'package:readmore/readmore.dart';
import 'package:testing/widgets/cast_and_crew.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<MovieModel> popularItems = List.of(popularImages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(colors: [
                      kBackgroundColor.withOpacity(0.8),
                      Colors.transparent,
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        popularItems[0].imageAsset.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                                "Dune",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "2021, Denis vilenuve",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white38,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "8.2",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              )
                            ],
                          )
                        ],
                      ),
                      // basic
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TagMovie("Romantic"),
                          const SizedBox(
                            width: 10,
                          ),
                          TagMovie("Manhua"),
                          const SizedBox(
                            width: 10,
                          ),
                          TagMovie("Manga"),
                        ],
                      ),
                    ],
                  ),
                ),
                // mô tả
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ReadMoreText(
                    "Cuộc trốn thoát này đã dẫn đến dòng thời gian bị rối loạn. Cục TVA – tổ chức bảo vệ tính nguyên vẹn của dòng chảy thời gian, buộc phải can thiệp, đi gô cổ ông thần này về làm việc. Tại đây, Loki có hai lựa chọn, một là giúp TVA ổn định lại thời gian, không thì bị tiêu hủy.",
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CastAndCrewWidget(casts: popularItems[0].cast!),
                //trailer
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Trailer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              image: const DecorationImage(
                                image: AssetImage("assets/trailer.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              color: kButtonColor.withOpacity(0.8),
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white54,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.dangerous_sharp,
                    color: kSearchbarColor,
                    size: 25,
                  ),
                ),
              )),
          Positioned(
            bottom: 5,
            right: 30,
            left: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: kButtonColor,
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "Xem Phim",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TagMovie(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: kSearchbarColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white38,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

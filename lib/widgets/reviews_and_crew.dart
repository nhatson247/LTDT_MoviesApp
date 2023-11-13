import 'package:flutter/material.dart';
import 'package:testing/api/constants.dart';
import 'package:testing/models/review.dart';

import '../utils/hook.dart';

class ReviewCard extends StatelessWidget {
  final List<Review> reviews;

  const ReviewCard({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          reviews.map((review) => buildReviewItem(context, review)).toList(),
    );
  }



  Widget buildReviewItem(BuildContext context, Review review) {
    return InkWell(
      onTap: () {
        showReviewDetailsDialog(context, review);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: review.avatarPath != null
                              ? NetworkImage(
                                  '${Constanst.imagePath}${review.avatarPath}')
                              : AssetImage('cast.jpg') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        review.author,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${calculateTimeAgo(review.createdAt)}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.redAccent,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  (review.rating ?? 0.0).toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.content,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void showReviewDetailsDialog(BuildContext context, Review review) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Review Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: review.avatarPath != null
                                ? NetworkImage(
                                '${Constanst.imagePath}${review.avatarPath}')
                                : AssetImage('cast.jpg') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          review.author,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              (review.rating ?? 0.0).toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${calculateTimeAgo(review.createdAt)} ",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${review.content}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          scrollable: true,
        );
      },
    );
  }

}

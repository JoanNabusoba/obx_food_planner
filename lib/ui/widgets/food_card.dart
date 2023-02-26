import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(int index,
      {super.key,
      required this.img,
      required this.title,
      required this.preptime,
      required this.description});

  final String img, title, preptime, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //img
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .2,
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lock_clock,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      preptime,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

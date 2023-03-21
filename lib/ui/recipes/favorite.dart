import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/main_controller.dart';
import '../widgets/food_card.dart';
import 'single_recipe.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.9;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favourites"),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          itemCount: MainController.to.user.value!.favourites.length,
          itemBuilder: (context, index) {
            var item = MainController.to.user.value!.favourites[index];
            return GestureDetector(
              onTap: () {
                MainController.to.selectRecipe(item);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SingleRecipe()));
              },
              child: FoodCard(
                index,
                description: "${item.details}".toString(),
                img: "${item.image}".toString(),
                preptime: "${item.preptime}".toString(),
                title: "${item.title}".toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}

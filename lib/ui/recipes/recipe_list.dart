import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/recipes/single_recipe.dart';

import '../widgets/food_card.dart';
import '../widgets/named_icon.dart';
import 'list_data.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.9;
    final double itemWidth = size.width / 2;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "OB Recipes",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black87,
                size: 28,
              ),
              onPressed: () {},
            ),
            NamedIcon(
              text: 'Notifications',
              iconData: Icons.notifications,
              notificationCount: 11,
              onTap: () {},
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black87,
                  size: 28,
                )),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (itemWidth / itemHeight),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              var item = foodList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SingleRecipe(
                            singleRecipe: item,
                          )));
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => SingleRecipe()));
                },
                child: FoodCard(
                  index,
                  description: "${item['desc']}".toString(),
                  img: "${item['image']}".toString(),
                  preptime: "${item['preptime']}".toString(),
                  title: "${item['title']}".toString(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

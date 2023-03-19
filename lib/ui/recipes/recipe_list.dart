import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:foodplanner_app/ui/mealplan/meal_plan_list.dart';
import 'package:foodplanner_app/ui/recipes/favorite.dart';
import 'package:foodplanner_app/ui/recipes/single_recipe.dart';
import 'package:get/get.dart';

import '../widgets/food_card.dart';
import '../widgets/named_icon.dart';
import 'add_edit_recipe.dart';
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
          automaticallyImplyLeading: false,
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
            // NamedIcon(
            //   text: 'Notifications',
            //   iconData: Icons.notifications,
            //   notificationCount: 11,
            //   onTap: () {},
            // ),
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.food_bank,
                        color: Color.fromRGBO(0, 191, 166, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Meal Plan")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(0, 191, 166, 1),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Favourites")
                    ],
                  ),
                ),
              ],
              offset: const Offset(0, 100),
              color: Colors.grey.shade200,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black87,
              ),
              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  Get.to(() => const MealPlanList());
                  // if value 2 show dialog
                } else if (value == 2) {
                  Get.to(() => const Favorite());
                }
              },
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemCount: MainController.to.recipeList.value.length,
              itemBuilder: (context, index) {
                var item = MainController.to.recipeList.value[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SingleRecipe(
                              singleRecipe: item,
                            )));
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
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(0, 191, 166, 1),
          onPressed: () {
            Get.to(() => const AddEditRecipe());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

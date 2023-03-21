import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:foodplanner_app/ui/mealplan/meal_plan_list.dart';
import 'package:foodplanner_app/ui/recipes/add_edit_recipe.dart';
import 'package:get/get.dart';

import '../widgets/fp_button.dart';

class SingleRecipe extends StatefulWidget {
  const SingleRecipe({super.key});

  @override
  State<SingleRecipe> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            decoration: BoxDecoration(
                color: Colors.teal.withOpacity(.5),
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(10))),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        body: Obx(
          () {
            var singleRecipe = MainController.to.selectedRecipe.value;
            return Stack(children: [
              //image
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .4,
                    decoration: BoxDecoration(
                      image: singleRecipe?.image == null ||
                              singleRecipe?.image == ""
                          ? const DecorationImage(
                              image: AssetImage("images/chef_purple.png"),
                              fit: BoxFit.contain)
                          : DecorationImage(
                              image: NetworkImage(singleRecipe?.image ?? ""),
                              fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
              //scrollview
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: size.height * .35,
                      ),
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          color: Colors.white),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${singleRecipe?.title}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${singleRecipe?.calories} calories",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black54),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 6),
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
                                        "${singleRecipe?.preptime}",
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
                              ],
                            ),

                            //details
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${singleRecipe?.details}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black54),
                            ),

                            //ingredients
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ingredients",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${singleRecipe?.ingredients?.join("\n")}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black54),
                            ),

                            //ingredients
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Steps",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${singleRecipe?.steps?.join("\n")}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.black54),
                            ),

                            //add to mealplan btn
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                // TextButton(
                                //     onPressed: () {},
                                //     child: Text(
                                //       "Delete Recipe",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .bodyLarge!
                                //           .copyWith(
                                //               fontWeight: FontWeight.bold,
                                //               color: Colors.red.shade300),
                                //     )),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: FPButton(
                                        text: "Add to MealPlan",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MealPlanList()),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ]),
                    ),
                    Positioned(
                      top: size.height * .35 - 30,
                      right: 35,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              MainController.to.selectRecipe(singleRecipe);
                              Get.to(() => const AddEditRecipe());
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              MainController.to
                                  .addToOrRemoveFromFavourites(singleRecipe!);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 191, 166, 1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: MainController.to.user.value != null &&
                                        MainController.to.user.value!.favourites
                                                .firstWhereOrNull((element) =>
                                                    element.id ==
                                                    singleRecipe!.id) !=
                                            null
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 32,
                                      )
                                    : Icon(
                                        Icons.favorite_outline,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}

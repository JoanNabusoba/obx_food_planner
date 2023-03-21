import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:foodplanner_app/backend/model/mealplan.dart';
import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:foodplanner_app/ui/mealplan/add_edit_mealplan.dart';
import 'package:foodplanner_app/ui/recipes/single_recipe.dart';
import 'package:foodplanner_app/ui/widgets/ob_listtile.dart';
import 'package:get/get.dart';

import '../widgets/tab_button.dart';

class MealPlanList extends StatefulWidget {
  const MealPlanList({super.key});

  @override
  State<MealPlanList> createState() => _MealPlanListState();
}

class _MealPlanListState extends State<MealPlanList> {
  var currentDate = DateTime.now().toLocal();
  var currentDay = "MON";
  var selectedMealTime = "BREAKFAST";

  var days = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];

  @override
  void initState() {
    setState(() {
      currentDay = days[currentDate.weekday];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          toolbarHeight: 65,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Meal Plan",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //day of the week
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    // TabButton(
                    //     btnBackgroundColor: Color.fromRGBO(0, 191, 166, 1),
                    //     btnTextColor: Colors.white,
                    //     buttonTitle: "Mon"),

                    ...days
                        .map((e) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                e != currentDay
                                    ? TabButton(
                                        onPressed: () {
                                          setState(() {
                                            currentDay = e;
                                          });
                                        },
                                        btnBackgroundColor: Colors.white,
                                        btnTextColor: Colors.black87,
                                        buttonTitle: e)
                                    : TabButton(
                                        onPressed: () {
                                          setState(() {
                                            currentDay = e;
                                          });
                                        },
                                        btnBackgroundColor:
                                            const Color.fromRGBO(
                                                0, 191, 166, 1),
                                        btnTextColor: Colors.white,
                                        buttonTitle: e),
                                const SizedBox(width: 8),
                              ],
                            ))
                        .toList()
                  ],
                ),
              ),

              //Title
              const SizedBox(height: 25),
              Text(
                "Tap pen to add recipes",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),

              //time
              // const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BREAKFAST",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedMealTime = "BREAKFAST";
                      });
                      showDialog(
                          context: context,
                          barrierColor: Colors.orange.withOpacity(.5),
                          builder: (context) => AddEditMealplan(
                                mealDay: currentDay,
                                mealTime: selectedMealTime,
                              ));
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _getRecipiesPerMealTime("BREAKFAST"),
              //time
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "LUNCH",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedMealTime = "LUNCH";
                      });
                      showDialog(
                          context: context,
                          barrierColor: Colors.orange.withOpacity(.5),
                          builder: (context) => AddEditMealplan(
                                mealDay: currentDay,
                                mealTime: selectedMealTime,
                              ));
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _getRecipiesPerMealTime("LUNCH"),

              //time
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "DINNER",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectedMealTime = "DINNER";
                      });
                      showDialog(
                          context: context,
                          barrierColor: Colors.orange.withOpacity(.5),
                          builder: (context) => AddEditMealplan(
                                mealDay: currentDay,
                                mealTime: selectedMealTime,
                              ));
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _getRecipiesPerMealTime("DINNER"),
            ]),
          ),
        ),
      ),
    );
  }

  _getRecipiesPerMealTime(mealtime) {
    return Obx(() {
      var mealPlan = MainController.to.mealPlanList.firstWhere(
          (element) =>
              element.dayofWeek == currentDay && element.time == "$mealtime",
          orElse: () => MealPlan(dayofWeek: "", time: ""));
      var recipies = mealPlan.id == 0 ? <Recipe>[] : mealPlan.recipe;

      //OBListTile

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: recipies.map((recipe) {
          return //OBListTile
              Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: OBListTile(
              img: "${recipe.image}",
              title: "${recipe.title}",
              subTitle: "${recipe.details}",
              onTileClick: () {
                MainController.to.selectRecipe(recipe);
                Get.to(() => const SingleRecipe());
              },
              deleteClick: () {
                MainController.to.deleteRecipeFromMealTime(mealPlan, recipe);
              },
            ),
          );
        }).toList(),
      );
    });
  }
}

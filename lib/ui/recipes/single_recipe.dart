import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/mealplan/meal_plan_list.dart';

import '../widgets/fp_button.dart';

class SingleRecipe extends StatefulWidget {
  const SingleRecipe({super.key, required this.singleRecipe});
  final Map singleRecipe;

  @override
  State<SingleRecipe> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          //image
          Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * .4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.singleRecipe['image']),
                        fit: BoxFit.cover)),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                          widget.singleRecipe['title'],
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
                              widget.singleRecipe['calories'] + " calories",
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
                                    widget.singleRecipe['preptime'],
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
                          widget.singleRecipe['desc'],
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
                          widget.singleRecipe['ingredients'],
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
                          widget.singleRecipe['steps'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black54),
                        ),

                        //add to mealplan btn
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
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
                        const SizedBox(
                          height: 50,
                        ),
                      ]),
                ),
                Positioned(
                  top: size.height * .35 - 30,
                  right: 35,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 191, 166, 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/mealplan/add_edit_mealplan.dart';
import 'package:foodplanner_app/ui/widgets/ob_listtile.dart';

import '../widgets/tab_button.dart';

class MealPlanList extends StatefulWidget {
  const MealPlanList({super.key});

  @override
  State<MealPlanList> createState() => _MealPlanListState();
}

class _MealPlanListState extends State<MealPlanList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                  children: const <Widget>[
                    TabButton(
                        btnBackgroundColor: Colors.white,
                        btnTextColor: Colors.black87,
                        buttonTitle: "Sun"),
                    SizedBox(width: 16),
                    TabButton(
                        btnBackgroundColor: Color.fromRGBO(0, 191, 166, 1),
                        btnTextColor: Colors.white,
                        buttonTitle: "Mon"),
                    SizedBox(width: 16),
                    TabButton(
                        btnBackgroundColor: Colors.white,
                        btnTextColor: Colors.black87,
                        buttonTitle: "Tue"),
                    SizedBox(width: 16),
                    TabButton(
                        btnBackgroundColor: Colors.white,
                        btnTextColor: Colors.black87,
                        buttonTitle: "Wed"),
                    TabButton(
                        btnBackgroundColor: Colors.white,
                        btnTextColor: Colors.black87,
                        buttonTitle: "Thur"),
                    TabButton(
                        btnBackgroundColor: Colors.white,
                        btnTextColor: Colors.black87,
                        buttonTitle: "Fri"),
                    TabButton(
                        btnBackgroundColor: Colors.white,
                        btnTextColor: Colors.black87,
                        buttonTitle: "Sat"),
                  ],
                ),
              ),

              //Title
              const SizedBox(height: 25),
              Text(
                "Monday, 20th March",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),

              //time
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "BREAKFAST",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              //OBListTile
              OBListTile(
                img: "images/2.jpg",
                title: "Tomato Soup",
                subTitle:
                    "Lorem ipsum dolor sit amet, conse ctetur adipiscing elit.",
                onTileClick: () {},
              ),

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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              //OBListTile
              OBListTile(
                img: "images/3.jpg",
                title: "Spaghettino",
                subTitle: "Lorem ipsum dolor sit amet",
                onTileClick: () {},
              ),

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
                      showDialog(
                          context: context,
                          barrierColor: Colors.orange.withOpacity(.5),
                          builder: (context) => const AddEditMealplan());
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

              //OBListTile
              OBListTile(
                img: "images/6.jpg",
                title: "Pizza Bambino",
                subTitle:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                onTileClick: () {},
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

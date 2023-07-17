import 'package:foodplanner_app/backend/model/user.dart';
import 'package:objectbox/objectbox.dart';

import 'mealplan.dart';

@Entity()
class Recipe {
  int id = 0;
  String? image;
  String? title;
  String? calories;
  String? preptime;
  String? details;
  List<String>? ingredients;
  List<String>? steps;

  Recipe({
    this.id = 0,
    required this.image,
    required this.title,
    required this.calories,
    required this.preptime,
    required this.details,
    required this.ingredients,
    required this.steps,
  });

  @Backlink('recipe')
  final mealplan = ToMany<MealPlan>();

  @Backlink('favourites')
  final users = ToMany<User>();
}

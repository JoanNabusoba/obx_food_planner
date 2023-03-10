import 'package:objectbox/objectbox.dart';

import 'mealplan.dart';

@Entity()
//@Sync()
class Recipe {
  int id = 0;
  String? title;
  String? calories;
  String? preptime;
  String? details;
  List<String>? ingredients;
  List<String>? steps;

  Recipe({
    this.id = 0,
    required this.title,
    required this.calories,
    required this.preptime,
    required this.details,
    required this.ingredients,
    required this.steps,
  });

  @Backlink('recipe')
  final mealplan = ToMany<MealPlan>();
}

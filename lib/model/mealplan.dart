import 'package:foodplanner_app/model/recipe.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
//@Sync()
class MealPlan {
  int id;
  String dayofWeek, time;

  MealPlan({
    this.id = 0,
    required this.dayofWeek,
    required this.time,
  });

  @Backlink('mealplan')
  final recipe = ToMany<Recipe>();
}

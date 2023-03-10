import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
//@Sync()
class MealPlan {
  int id = 0;
  String? dayofWeek;
  String? time;

  MealPlan({
    this.id = 0,
    required this.dayofWeek,
    required this.time,
  });

  final recipe = ToMany<Recipe>();
}

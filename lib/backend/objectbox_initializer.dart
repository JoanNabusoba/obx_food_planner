import 'dart:io';

import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:foodplanner_app/backend/model/mealplan.dart';
import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:foodplanner_app/backend/model/user.dart';
import 'package:foodplanner_app/objectbox.g.dart';
import 'package:foodplanner_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ViewModel {
  late final Store store;

  late final Box<MealPlan> mealPlanBox;
  late final Box<User> userBox;
  late final Box<Recipe> recipeBox;

  ViewModel._create(this.store) {
    mealPlanBox = Box<MealPlan>(store);
    userBox = Box<User>(store);
    recipeBox = Box<Recipe>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ViewModel> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    final store = await openStore(
        directory: "${appDocDirectory.path}/obx_foodplanner_db");
    return ViewModel._create(store);
  }

  int signUpUser(String name, String email, String password) {
    int result = 0;
    //check whether user exists by finding the first email
    var user = userBox.query(User_.email.equals(email)).build().findFirst();
    if (user == null) {
      user = User.newUser(User(name: name, email: email, password: password));
      result = userBox.put(user);
    } else {
      Utils.errorSnackbar("User already exists. Login or use another email");
    }
    return result;
  }

  findByEmail(email) {
    return userBox.query(User_.email.equals(email)).build().findFirst();
  }

  Stream<List<Recipe>> getRecipeStream() {
    final builder =
        recipeBox.query(Recipe_.title.contains("", caseSensitive: false));

    return builder.watch(triggerImmediately: true).map((query) {
      if (MainController.to.searchQuery.isNotEmpty) {
        return (query
              ..param(Recipe_.title).value =
                  MainController.to.searchQuery.value)
            .find();
      }
      return query.find();
    });
  }

  Stream<List<MealPlan>> getMealPlanStream() {
    final builder = mealPlanBox.query();
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  List<Recipe> getMealPlanRecipes(day, mealTime) {
    final builder = mealPlanBox.query(
        MealPlan_.dayofWeek.equals(day).and(MealPlan_.time.equals(mealTime)));
    var mealtime = builder.build().findFirst();
    return mealtime?.recipe.toList() ?? [];
  }
}

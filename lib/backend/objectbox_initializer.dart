import 'dart:io';

import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:foodplanner_app/backend/model/mealplan.dart';
import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:foodplanner_app/backend/model/user.dart';
import 'package:foodplanner_app/objectbox.g.dart';
import 'package:foodplanner_app/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class OBxInitializer {
  late final Store store;

  late final Box<MealPlan> mealPlanBox;
  late final Box<User> userBox;
  late final Box<Recipe> recipeBox;

  OBxInitializer._create(this.store) {
    mealPlanBox = Box<MealPlan>(store);
    userBox = Box<User>(store);
    recipeBox = Box<Recipe>(store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<OBxInitializer> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    final store = await openStore(
        //create db in this dir
        directory: "${appDocDirectory.path}/obx_foodplanner_db");
    return OBxInitializer._create(store);
  }

//<!-- method to sign up user
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
    final builder = recipeBox.query(Recipe_.title
        .contains(MainController.to.searchQuery.value, caseSensitive: false));

    return builder.watch(triggerImmediately: true).map((query) {
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

  Stream<List<Recipe>> getFavoriteStream() {
    final builder = recipeBox.query(Recipe_.id.oneOf(
        MainController.to.user.value == null
            ? []
            : MainController.to.user.value!.favourites
                .map((favourite) => favourite.id)
                .toList()));

    return builder.watch(triggerImmediately: true).map((query) {
      return query.find();
    });
  }
}

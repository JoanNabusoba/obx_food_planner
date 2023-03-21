import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:foodplanner_app/backend/model/mealplan.dart';
import 'package:foodplanner_app/backend/model/recipe.dart';
import 'package:foodplanner_app/backend/model/user.dart';
import 'package:foodplanner_app/main.dart';
import 'package:foodplanner_app/objectbox.g.dart';
import 'package:foodplanner_app/utils/utils.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  var user = Rxn<User>();
  var recipeList = <Recipe>[].obs;
  var selectedRecipe = Rxn<Recipe>();
  var mealPlanList = <MealPlan>[].obs;
  var searchQuery = "".obs;

  //selecting recipes to add to mealtime
  var selectedMealTime = "".obs;
  var selectedDayTime = "".obs;

  @override
  onReady() {
    recipeList.bindStream(vm.getRecipeStream());
    mealPlanList.bindStream(vm.getMealPlanStream());
  }

  login(String email, String password) {
    //print(vm.userBox.getAll().map((e) => e.email).join(","));

    if (email.isEmpty || !email.isEmail) {
      Utils.errorSnackbar("Please enter valid email");
      return false;
    }
    User? userLoggedIn = vm.findByEmail(email);
    if (userLoggedIn == null) {
      Utils.errorSnackbar("User not found in our database. Please sign up");
      return false;
    }
    //when user is found with wrong pass
    if (!userLoggedIn.login(password)) {
      Utils.errorSnackbar("Wrong password. Try again");
      return false;
    }
    user.value = userLoggedIn;
    update();
    //user found and logged in
    Utils.successSnackbar("Login successful");
    return true;
  }

  signUp(String name, String email, String password) {
    if (name.isEmpty) {
      Utils.errorSnackbar("Please enter your name");
      return false;
    }
    if (email.isEmpty || !email.isEmail) {
      Utils.errorSnackbar("Please enter valid email");
      return false;
    }
    if (password.isEmpty) {
      Utils.errorSnackbar("Please enter password");
      return false;
    }
    User? userLoggedIn = vm.findByEmail(email);
    if (userLoggedIn != null) {
      Utils.errorSnackbar("User with this account already exist, login");
      return false;
    }
    if (vm.signUpUser(name, email, password) < 1) {
      Utils.errorSnackbar("User not registered, please try again");
      return false;
    }
    User? signedInUser = vm.findByEmail(email);

    user.value = signedInUser;
    update();
    //user created account
    Utils.successSnackbar("Sign up successful");
    return true;
  }

  //add recipe
  addRecipe(String title, String preptime, String calories, String description,
      List<String> ingredients, List<String> steps, File? image) async {
    String imageUrl = "";

    Utils.showLoader("Saving Recipe");
    if (title.isEmpty) {
      Utils.errorSnackbar("Title field should not be empty");
    } else if (preptime.isEmpty) {
      Utils.errorSnackbar("Preptime field should not be empty");
    } else if (calories.isEmpty) {
      Utils.errorSnackbar("Calories field should not be empty");
    } else if (description.isEmpty) {
      Utils.errorSnackbar("Description field should not be empty");
    } else if (ingredients.isEmpty) {
      Utils.errorSnackbar("Please add at least one ingredient");
    } else if (steps.isEmpty) {
      Utils.errorSnackbar("Add at least a step tot he recipe");
    } else {
      if (image != null) {
        imageUrl = await uploadFile(image);
      }

      vm.recipeBox.put(Recipe(
          image: imageUrl,
          title: title,
          preptime: preptime,
          calories: calories,
          ingredients: ingredients,
          details: description,
          steps: steps));
      Utils.closeLoader();
      Utils.successSnackbar("Recipe saved");
      return true;
    }
    Utils.closeLoader();

    return false;
  }

  //edit recipe
  editRecipe(
      int id,
      String title,
      String preptime,
      String calories,
      String description,
      List<String> ingredients,
      List<String> steps,
      File? image) async {
    String imageUrl = "";

    Utils.showLoader("Saving Recipe");
    if (title.isEmpty) {
      Utils.errorSnackbar("Title field should not be empty");
    } else if (preptime.isEmpty) {
      Utils.errorSnackbar("Preptime field should not be empty");
    } else if (calories.isEmpty) {
      Utils.errorSnackbar("Calories field should not be empty");
    } else if (description.isEmpty) {
      Utils.errorSnackbar("Description field should not be empty");
    } else if (ingredients.isEmpty) {
      Utils.errorSnackbar("Please add at least one ingredient");
    } else if (steps.isEmpty) {
      Utils.errorSnackbar("Add at least a step to the recipe");
    } else {
      //sets img url to the selected's recipe img url
      imageUrl = selectedRecipe.value?.image ?? "";
      //if image selected isn't empty upload img and set the the recipe's img url to the uploaded image url
      if (image != null) {
        imageUrl = await uploadFile(image);
      }

      vm.recipeBox.put(Recipe(
          id: id,
          image: imageUrl,
          title: title,
          preptime: preptime,
          calories: calories,
          ingredients: ingredients,
          details: description,
          steps: steps));
      Utils.closeLoader();
      Utils.successSnackbar("Recipe saved");

      return true;
    }
    Utils.closeLoader();
    return false;
  }

  //select recipe
  selectRecipe(Recipe? recipe) {
    selectedRecipe.value = recipe;
    update();
  }

  //select meal day and time
  selectMealDayAndTime(mealTime, mealDay) {
    selectedDayTime.value = mealDay;
    selectedMealTime.value = mealTime;

    update();
  }

  //upload file
  Future<String> uploadFile(File file) async {
    final cloudinary = Cloudinary.signedConfig(
      apiKey: "--------",
      apiSecret: "----------",
      cloudName: '----------',
    );

    CloudinaryResponse response = await cloudinary.upload(
        file: file.path,
        fileBytes: file.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {
          //print('Uploading image from file with progress: $count/$total');
        });
    if (response.isSuccessful) {
      return response.url ?? "";
    }
    return "";
  }

  //add to mealplan
  addToMealplan(int recipeId, String dayOfWeek, String dayTime) {
    var recipeToadd = vm.recipeBox.get(recipeId);

    if (recipeToadd == null) {
      Utils.errorSnackbar("Please select a recipe");
      return false;
    }

    Utils.showLoader("Adding recipe to mealplan");
    if (dayOfWeek.isEmpty) {
      Utils.errorSnackbar("Select a day of the week first");
    } else if (dayTime.isEmpty) {
      Utils.errorSnackbar("Select either breakfast, lunch or dinner");
    }
    //add if a daytime has a recipe
    else {
      //check if there is an existing mealplan on that day and that day time;
      var existingMealPlan = vm.mealPlanBox
          .query(MealPlan_.dayofWeek
              .equals(dayOfWeek)
              .and(MealPlan_.time.equals(dayTime)))
          .build()
          .findFirst();

      // if recipe exists in that mealtime
      if (existingMealPlan != null) {
        if (existingMealPlan.recipe
            .where((element) => element.id == recipeId)
            .toList()
            .isNotEmpty) {
          Utils.errorSnackbar(
              "Recipe already exists foe that mealtime. Select a different recipe");
          return false;
        } else {
          existingMealPlan.recipe.add(recipeToadd);
          vm.mealPlanBox.put(existingMealPlan);
          Utils.closeLoader();
          Utils.successSnackbar("Meal plan updated");
          return true;
        }
      }
      //if that mealtime doesn't exist
      //create a  new meal plan with that recipe
      var mealPlan = MealPlan(dayofWeek: dayOfWeek, time: dayTime);
      //adding recipe
      mealPlan.recipe.add(recipeToadd);
      //create mealplan
      vm.mealPlanBox.put(mealPlan);

      Utils.closeLoader();
      Utils.successSnackbar("Meal plan updated");

      return true;
    }
    return false;
  }

  //delete meal time
  deleteRecipeFromMealTime(MealPlan mealPlan, Recipe recipe) {
    mealPlan.recipe.remove(recipe);
    vm.mealPlanBox.put(mealPlan);
  }

  setSearchText(searchText) {
    searchQuery.value = searchText;
    update();
    recipeList.bindStream(vm.getRecipeStream());
  }

  //add to favourites
  addToOrRemoveFromFavourites(Recipe recipe) {
    var addUser = user.value;
    if (addUser == null) {
      Utils.errorSnackbar("Cannot favorite a recipe");
      return false;
    }

    if (addUser.favourites
            .firstWhereOrNull((element) => element.id == recipe.id) !=
        null) {
      addUser.favourites.removeWhere((element) => element.id == recipe.id);
      vm.userBox.put(addUser);
      user.value = vm.userBox.get(addUser.id);
      update();
      print(user.value!.favourites.length);

      Utils.successSnackbar("Recipe unfavourited!");
    } else {
      addUser.favourites.add(recipe);
      vm.userBox.put(addUser);
      user.value = vm.userBox.get(addUser.id);
      update();

      print(user.value!.favourites.length);
      Utils.successSnackbar("Recipe favourited!");
    }
  }
}

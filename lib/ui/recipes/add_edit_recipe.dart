import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:foodplanner_app/main.dart';
import 'package:get/get.dart';

import '../widgets/fp_button.dart';
import '../widgets/fp_textfield.dart';

class AddEditRecipe extends StatefulWidget {
  const AddEditRecipe({super.key});

  @override
  State<AddEditRecipe> createState() => _AddEditRecipeState();
}

class _AddEditRecipeState extends State<AddEditRecipe> {
  TextEditingController titleController = TextEditingController();
  TextEditingController preptimeController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController stepsController = TextEditingController();

  List<String> ingredientList = [];
  List<String> stepsList = [];

  File? image;

  @override
  void initState() {
    if (MainController.to.selectedRecipe.value != null) {
      titleController = TextEditingController(
          text: MainController.to.selectedRecipe.value!.title);
      preptimeController = TextEditingController(
          text: MainController.to.selectedRecipe.value!.preptime);
      caloriesController = TextEditingController(
          text: MainController.to.selectedRecipe.value!.calories);
      detailsController = TextEditingController(
          text: MainController.to.selectedRecipe.value!.details);
      setState(() {
        ingredientList =
            MainController.to.selectedRecipe.value!.ingredients ?? [];
        stepsList = MainController.to.selectedRecipe.value!.steps ?? [];
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            )),
        title: Text(MainController.to.selectedRecipe.value != null
            ? "Edit Recipe"
            : "Add Recipe"),
        actions: [
          TextButton.icon(
              onPressed: () async {
                if (MainController.to.selectedRecipe.value != null) {
                  if (await MainController.to.editRecipe(
                      MainController.to.selectedRecipe.value?.id ?? 0,
                      titleController.text,
                      preptimeController.text,
                      caloriesController.text,
                      detailsController.text,
                      ingredientList,
                      stepsList,
                      image)) {
                    MainController.to.selectRecipe(vm.recipeBox
                        .get(MainController.to.selectedRecipe.value?.id ?? 0));
                    Get.close(1);
                  }
                } else {
                  if (await MainController.to.addRecipe(
                      titleController.text,
                      preptimeController.text,
                      caloriesController.text,
                      detailsController.text,
                      ingredientList,
                      stepsList,
                      image)) {
                    Get.close(1);
                  }
                }
              },
              icon: const Icon(
                Icons.save_rounded,
                color: Colors.white,
              ),
              label: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                  );
                  if (result != null && result.paths.first != null) {
                    setState(() {
                      image = File(result.paths.first ?? "");
                    });
                  }
                },
                child: Container(
                  height: Get.height * .25,
                  width: Get.width * .9,
                  decoration: BoxDecoration(
                      image: image == null
                          ? ((MainController.to.selectedRecipe.value != null &&
                                  MainController
                                          .to.selectedRecipe.value?.image !=
                                      null &&
                                  MainController
                                          .to.selectedRecipe.value?.image !=
                                      "")
                              ? DecorationImage(
                                  image: NetworkImage(MainController
                                          .to.selectedRecipe.value?.image ??
                                      ""),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: AssetImage("images/chef_purple.png"),
                                  fit: BoxFit.cover))
                          : DecorationImage(
                              image: FileImage(image!),
                              fit: BoxFit.cover,
                            )),
                  child: image == null
                      ? Container(
                          height: 20,
                          width: 300,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.5)),
                          child: const Text("Tap to upload image"),
                        )
                      : Container(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    FPTextField(
                      keyboardinputType: TextInputType.text,
                      hintText: 'Enter recipe title..',
                      obscureTxt: false,
                      formfieldName: 'title',
                      iconData: Icons.restaurant,
                      controller: titleController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FPTextField(
                            keyboardinputType: TextInputType.text,
                            hintText: 'Preptime..',
                            obscureTxt: false,
                            formfieldName: 'preptime',
                            iconData: Icons.timer,
                            controller: preptimeController,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: FPTextField(
                            keyboardinputType: TextInputType.number,
                            hintText: 'Calories..',
                            obscureTxt: false,
                            formfieldName: 'calories',
                            iconData: Icons.fireplace,
                            controller: caloriesController,
                          ),
                        ),
                      ],
                    ),
                    FPTextField(
                      keyboardinputType: TextInputType.text,
                      hintText: 'Description..',
                      obscureTxt: false,
                      formfieldName: 'description',
                      iconData: Icons.note,
                      controller: detailsController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Ingredients",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ingredients(),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: FPButton(
                          text: "Add an ingredient",
                          onPressed: () {
                            showEditIngredientModal(null);
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Steps",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    steps(),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: FPButton(
                          text: "Add a step",
                          onPressed: () {
                            showEditStepsModal(null);
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ingredients() {
    if (ingredientList.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: ingredientList
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 15,
                          child: Text("${ingredientList.indexOf(e) + 1}.")),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                showEditIngredientModal(e);
                              },
                              child: Text(e))),
                      InkWell(
                        onTap: () {
                          setState(() {
                            ingredientList.removeAt(stepsList.indexOf(e));
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade400,
                          ),
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
      );
    }
    return const Text(
      "Tap below to add ingredients",
      style: TextStyle(color: Colors.black38),
    );
  }

  Widget steps() {
    if (stepsList.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: stepsList
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 15,
                          child: Text("${stepsList.indexOf(e) + 1}.")),
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                showEditStepsModal(e);
                              },
                              child: Text(e))),
                      InkWell(
                        onTap: () {
                          setState(() {
                            stepsList.removeAt(stepsList.indexOf(e));
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      );
    }
    return const Text(
      "Tap to add steps to the recipe",
      style: TextStyle(color: Colors.black38),
    );
  }

  showEditIngredientModal(selectedIngredient) {
    if (selectedIngredient != null) {
      ingredientsController.text = selectedIngredient;
    }
    Get.dialog(
      Material(
        color: Colors.white.withOpacity(.5),
        child: Container(
          width: Get.width * .95,
          height: Get.height * .8,
          alignment: Alignment.center,
          color: Colors.white.withOpacity(.5),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${ingredientsController.text.isEmpty ? "Create" : "Edit"} ingredient",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                FPTextField(
                  keyboardinputType: TextInputType.text,
                  hintText: 'Enter ingredient..',
                  obscureTxt: false,
                  formfieldName: 'ingredients',
                  iconData: Icons.edit,
                  controller: ingredientsController,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: FPButton(
                      text: "Save",
                      onPressed: () {
                        if (ingredientsController.text.isNotEmpty) {
                          setState(() {
                            if (selectedIngredient != null) {
                              ingredientList[ingredientList
                                      .indexOf(selectedIngredient)] =
                                  ingredientsController.text;
                            } else {
                              ingredientList.add(ingredientsController.text);
                            }
                          });
                          ingredientsController.text = "";
                          Get.back();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showEditStepsModal(selectedStep) {
    if (selectedStep != null) {
      stepsController.text = selectedStep;
    }
    Get.dialog(
      Material(
        color: Colors.white.withOpacity(.5),
        child: Container(
          width: Get.width * .95,
          height: Get.height * .8,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          alignment: Alignment.center,
          color: Colors.white.withOpacity(.5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${ingredientsController.text.isEmpty ? "Create" : "Edit"} step",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                FPTextField(
                  keyboardinputType: TextInputType.text,
                  hintText: 'Enter a step..',
                  obscureTxt: false,
                  formfieldName: 'step',
                  iconData: Icons.edit,
                  controller: stepsController,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: FPButton(
                      text: "Save",
                      onPressed: () {
                        if (stepsController.text.isNotEmpty) {
                          setState(() {
                            if (selectedStep != null) {
                              stepsList[stepsList.indexOf(selectedStep)] =
                                  stepsController.text;
                            } else {
                              stepsList.add(stepsController.text);
                            }
                          });
                          stepsController.text = "";
                          Get.back();
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

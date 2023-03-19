import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditRecipe extends StatefulWidget {
  const AddEditRecipe({super.key});

  @override
  State<AddEditRecipe> createState() => _AddEditRecipeState();
}

class _AddEditRecipeState extends State<AddEditRecipe> {
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
        title: const Text("Add Recipe"),
      ),
    );
  }
}

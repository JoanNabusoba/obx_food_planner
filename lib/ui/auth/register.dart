import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/auth/login.dart';
import 'package:foodplanner_app/ui/recipes/recipe_list.dart';
import 'package:foodplanner_app/utils/utils.dart';
import 'package:get/get.dart';
import '../../backend/main_controller.dart';
import '../widgets/fp_button.dart';
import '../widgets/fp_textfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 30),

              //back button icon
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              const SizedBox(height: 15),

              //Title login and subtitle
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create Account",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 5),
                    Text("Please fill in the inputs below",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),

              //Textboxes
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    FPTextField(
                      keyboardinputType: TextInputType.name,
                      hintText: 'Your name',
                      obscureTxt: false,
                      formfieldName: 'name',
                      iconData: Icons.mail,
                      controller: nameController,
                    ),
                    const SizedBox(height: 10),
                    FPTextField(
                      keyboardinputType: TextInputType.emailAddress,
                      hintText: 'Your email',
                      obscureTxt: false,
                      formfieldName: 'email',
                      iconData: Icons.mail,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    FPTextField(
                      keyboardinputType: TextInputType.text,
                      hintText: 'Your password',
                      obscureTxt: true,
                      formfieldName: 'password',
                      iconData: Icons.lock,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 10),
                    FPTextField(
                      keyboardinputType: TextInputType.text,
                      hintText: 'Confirm password',
                      obscureTxt: true,
                      formfieldName: 'confirm_password',
                      iconData: Icons.lock,
                      controller: repeatPasswordController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //login button
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: FPButton(
                    text: "SIGN UP",
                    onPressed: () {
                      if (passwordController.text !=
                          repeatPasswordController.text) {
                        Utils.errorSnackbar("Password Missmatch!");
                      } else if (MainController.to.signUp(nameController.text,
                          emailController.text, passwordController.text)) {
                        Get.to(() => const RecipeList());
                      }
                    }),
              ),
              const SizedBox(height: 35),

              //to LOGIN
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("Login",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: const Color.fromRGBO(0, 191, 166, 1),
                                  fontWeight: FontWeight.bold)),
                    ],
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}

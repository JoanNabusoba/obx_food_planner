import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/auth/login.dart';
import 'package:foodplanner_app/ui/recipes/recipe_list.dart';
import '../widgets/fp_button.dart';
import '../widgets/fp_textfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                    icon: Icon(Icons.arrow_back)),
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
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    FPTextField(
                      keyboardinputType: TextInputType.emailAddress,
                      hintText: 'Your email',
                      obscureTxt: false,
                      formfieldName: 'email',
                      iconData: Icons.mail,
                    ),
                    SizedBox(height: 10),
                    FPTextField(
                      keyboardinputType: TextInputType.text,
                      hintText: 'Your password',
                      obscureTxt: true,
                      formfieldName: 'password',
                      iconData: Icons.lock,
                    ),
                    SizedBox(height: 10),
                    FPTextField(
                      keyboardinputType: TextInputType.text,
                      hintText: 'Confirm password',
                      obscureTxt: true,
                      formfieldName: 'confirm_password',
                      iconData: Icons.lock,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipeList()),
                      );
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

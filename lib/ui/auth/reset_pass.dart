import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/auth/forgot_pass.dart';
import 'package:foodplanner_app/ui/recipes/recipe_list.dart';

import '../widgets/fp_button.dart';
import '../widgets/fp_textfield.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
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
                        MaterialPageRoute(
                            builder: (context) => const ForgotPass()),
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
                    Text("Reset Password",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 5),
                    Text("Enter your new password below",
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
                      hintText: 'New password',
                      obscureTxt: false,
                      formfieldName: 'newpass',
                      iconData: Icons.lock,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FPTextField(
                      keyboardinputType: TextInputType.emailAddress,
                      hintText: 'Repeat new password',
                      obscureTxt: false,
                      formfieldName: 'repeat_newpass',
                      iconData: Icons.lock,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),

              //save pass button
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: FPButton(
                    text: "SAVE PASSWORD",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipeList()),
                      );
                    }),
              ),
              const SizedBox(height: 35),
            ]),
          ),
        ),
      ),
    );
  }
}

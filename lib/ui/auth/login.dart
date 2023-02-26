import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/auth/forgot_pass.dart';
import 'package:foodplanner_app/ui/auth/register.dart';
import 'package:foodplanner_app/ui/recipes/recipe_list.dart';
import 'package:foodplanner_app/ui/widgets/fp_button.dart';
import 'package:foodplanner_app/ui/widgets/fp_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(children: [
              //Image
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                padding: const EdgeInsets.all(50),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 191, 166, 1),
                  // image: const DecorationImage(
                  //     image: AssetImage("images/login.png"),
                  //     fit: BoxFit.contain),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
                child: Image(
                  image: AssetImage("images/check-mark.png"),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              //Title login and subtitle
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 5),
                    Text("Please sign in to continue",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),

              //Textboxes
              SizedBox(height: 20),
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
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //login button
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: FPButton(
                    text: "LOGIN",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipeList()),
                      );
                    }),
              ),
              const SizedBox(height: 10),

              //forgot password
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPass()),
                    );
                  },
                  child: Text("Forgot Password?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Color.fromRGBO(0, 191, 166, 1)))),
              const SizedBox(height: 30),

              //to sign up
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have an account?",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("Sign up",
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

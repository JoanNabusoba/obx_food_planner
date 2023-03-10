import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodplanner_app/backend/main_controller.dart';
import 'package:foodplanner_app/ui/auth/forgot_pass.dart';
import 'package:foodplanner_app/ui/auth/register.dart';
import 'package:foodplanner_app/ui/recipes/recipe_list.dart';
import 'package:foodplanner_app/ui/widgets/fp_button.dart';
import 'package:foodplanner_app/ui/widgets/fp_textfield.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Image
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .28,
                  padding: const EdgeInsets.all(50),
                  decoration: const BoxDecoration(
                    //color: const Color.fromRGBO(0, 191, 166, 1),
                    image: DecorationImage(
                        image: AssetImage("images/gradient-3.jpg"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: const Image(
                    image: AssetImage("images/oblogo_white.png"),
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
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
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
                        if (MainController.to.login(
                            emailController.text, passwordController.text)) {
                          Get.to(() => const RecipeList());
                        }
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color.fromRGBO(0, 191, 166, 1)))),

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
                      Text("Don\\'t have an account?",
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
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),

                //URL TO GIT
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontStyle: FontStyle.italic),
                        text: "Example App powered by ",
                      ),
                      TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        text: "ObjectBox",
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("images/github.png"),
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline),
                            text: "Source Code",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                String url =
                                    "https://github.com/JoanNabusoba/obx_food_planner";
                                var urllaunchable = await canLaunchUrl(Uri.parse(
                                    url)); //canLaunch is from url_launcher package
                                if (urllaunchable) {
                                  await launchUrl(Uri.parse(
                                      url)); //launch is from url_launcher package to launch URL
                                } else {
                                  debugPrint("URL can't be launched.");
                                }
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

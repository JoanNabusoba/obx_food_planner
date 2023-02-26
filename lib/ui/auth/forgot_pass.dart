import 'package:flutter/material.dart';
import 'package:foodplanner_app/ui/auth/reset_pass.dart';

import '../widgets/fp_button.dart';
import '../widgets/fp_textfield.dart';
import 'login.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
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
                    Text("Forgot your password?",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 5),
                    Text("Enter your email below",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),

              //Textboxes
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FPTextField(
                  keyboardinputType: TextInputType.emailAddress,
                  hintText: 'Your email',
                  obscureTxt: false,
                  formfieldName: 'email',
                  iconData: Icons.mail,
                ),
              ),
              const SizedBox(height: 35),

              //reset pass button
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: FPButton(
                    text: "RESET PASSWORD",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPass()),
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

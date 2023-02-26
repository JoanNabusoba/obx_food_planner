import 'package:flutter/material.dart';

class FPTextField extends StatelessWidget {
  const FPTextField(
      {Key? key,
      required this.keyboardinputType,
      required this.hintText,
      required this.obscureTxt,
      required this.formfieldName,
      required this.iconData})
      : super(key: key);
  final TextInputType keyboardinputType;
  final String hintText, formfieldName;
  final bool obscureTxt;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        obscureText: obscureTxt,
        keyboardType: keyboardinputType,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          prefixIcon: Icon(
            iconData,
            size: 20,
            color: Colors.orange.shade300,
          ),
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.all(17),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

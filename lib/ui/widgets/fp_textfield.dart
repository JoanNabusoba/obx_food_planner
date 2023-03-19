import 'package:flutter/material.dart';

class FPTextField extends StatelessWidget {
  const FPTextField(
      {Key? key,
      required this.keyboardinputType,
      required this.hintText,
      required this.obscureTxt,
      required this.formfieldName,
      required this.iconData,
      this.controller})
      : super(key: key);
  final TextInputType keyboardinputType;
  final String hintText, formfieldName;
  final bool obscureTxt;
  final IconData iconData;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
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
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(17),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

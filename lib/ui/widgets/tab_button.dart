import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String buttonTitle;
  final Color btnTextColor, btnBackgroundColor;
  final VoidCallback onPressed;

  const TabButton(
      {Key? key,
      required this.buttonTitle,
      required this.btnTextColor,
      required this.btnBackgroundColor,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(btnBackgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(buttonTitle,
          style: TextStyle(fontWeight: FontWeight.bold, color: btnTextColor)),
    );
  }
}

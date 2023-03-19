import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoaderContainer extends StatelessWidget {
  const LoaderContainer({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(.5),
      child: Container(
        color: Colors.black.withOpacity(.5),
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Color.fromRGBO(0, 191, 166, 1),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

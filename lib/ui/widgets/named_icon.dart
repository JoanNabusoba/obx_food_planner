import 'package:flutter/material.dart';

class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  final int notificationCount;

  const NamedIcon({
    Key? key,
    this.onTap,
    required this.text,
    required this.iconData,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colors.black87,
                  size: 28,
                ),
                //Text(text, overflow: TextOverflow.ellipsis),
              ],
            ),
            Positioned(
              top: 0,
              right: 6,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                alignment: Alignment.center,
                child: Text(
                  '$notificationCount',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

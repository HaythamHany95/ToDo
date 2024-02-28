import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_theme.dart';

class CircleElevatedButton extends StatelessWidget {
  final void Function() onPressed;

  const CircleElevatedButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyTheme.primaryColor,
        elevation: 20,
        shadowColor: Colors.black,
        shape: CircleBorder(
          side: BorderSide(width: 5, color: MyTheme.whiteColor),
        ),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: ImageIcon(
        const AssetImage(
          "assets/images/icon_check.png",
        ),
        color: MyTheme.whiteColor,
      ),
    );
  }
}

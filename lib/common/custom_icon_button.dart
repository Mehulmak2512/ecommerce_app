import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  const CustomIconButton({super.key, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: ConstantColors.white,
          size: 26,
        ));
  }
}

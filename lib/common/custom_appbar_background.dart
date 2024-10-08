import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarBackground extends StatelessWidget {
  const CustomAppBarBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          gradient: LinearGradient(colors: [
            ConstantColors.greyShade400,
            ConstantColors.pinkAccentShade200,
            ConstantColors.greyShade400,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)
      ),
    );
  }
}
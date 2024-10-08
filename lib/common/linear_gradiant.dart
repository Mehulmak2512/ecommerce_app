import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:flutter/material.dart';

Gradient linearGradient() {
  return const LinearGradient(colors: [
    ConstantColors.greyShade400,
    ConstantColors.pinkAccentShade200,
    ConstantColors.greyShade400,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
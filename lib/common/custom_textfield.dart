import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obsureText;
  final String errorText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
     this.obsureText = false,
    required this.errorText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter the $errorText";
        }
        return null;
      },
      style: TextStyle(color: ConstantColors.black, fontWeight: FontWeight.bold),
      obscureText: obsureText,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(

        label: Text(
          labelText,
          style: TextStyle(color: ConstantColors.grey, fontWeight: FontWeight.bold),
        ),
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: prefixIcon != null ? prefixIcon : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: ConstantColors.grey)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: ConstantColors.pinkAccent)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: ConstantColors.red)),
      ),
    );
  }
}

import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.wifi_off_outlined,size: 150,),
               Text("No Internet\nConnection",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ConstantColors.black,fontSize: 30,fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}


import 'dart:async';

import 'package:ecommerce_app/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {

  isLogin(context) async {


    final currentUserId = FirebaseAuth.instance.currentUser?.uid.toString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String useId = preferences.getString("uId") ?? "";

    if(useId == currentUserId){
      bool isUser = preferences.getBool("isUser") ?? false;
      bool isSeller = preferences.getBool("isSeller") ?? false;

      Timer(const Duration(milliseconds: 5500), (){
        if(isUser == true && isSeller == false){
          Navigator.pushNamed(context, AppRoutes.homeScreen);
        }else if (isSeller == true && isUser == false){
          Navigator.pushNamed(context, AppRoutes.sellerHomeScreen);
        }else{
          Navigator.pushNamed(context, AppRoutes.loginScreen);
        }
      });

    }else{
      Timer(const Duration(milliseconds: 3000), (){
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      });
    }
  }
}
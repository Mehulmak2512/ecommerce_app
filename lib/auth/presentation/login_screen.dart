import 'dart:developer';
import 'package:ecommerce_app/auth/controller/seller_auth.dart';
import 'package:ecommerce_app/auth/controller/user_auth.dart';
import 'package:ecommerce_app/common/custom_textfield.dart';
import 'package:ecommerce_app/common/linear_gradiant.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final args = ModalRoute.of(context)?.settings.arguments as bool?;

    final emailController = useTextEditingController();
    final emailFocusNode = useFocusNode();
    final passwordController = useTextEditingController();
    final passwordFocusNode= useFocusNode();
    final isObsureText = useValueNotifier(true);
    final isLoading = useValueNotifier(false);
    final formKey = GlobalKey<FormState>();

    emailController.text = "abc@gmail.com";
    passwordController.text = "123456";

    return GestureDetector(
      onTap: (){
        emailFocusNode.unfocus();
        passwordFocusNode.unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: linearGradient(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                "WELCOME...!",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  color: ConstantColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0,left: 18.0, top: 40,bottom: 30),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            errorText: 'email',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ValueListenableBuilder(
                            valueListenable: isObsureText,
                            builder: (BuildContext context, bool value, Widget? child) {
                              return CustomTextField(
                                controller: passwordController,
                                labelText: 'Password',
                                prefixIcon:const Icon(Icons.lock_outline),
                                errorText: 'password',
                                suffixIcon: GestureDetector(
                                    onTap: (){
                                      isObsureText.value = !isObsureText.value;
                                    },
                                    child: Icon( value ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
                                obsureText: value,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          GestureDetector(
                            onTap: (){
                              if(formKey.currentState!.validate()){
                                isLoading.value = true;
                                if (args == false || args == null) {
                                  ref.read(userAuthProvider.notifier).loginWithEmailAndPassword(
                                      email: emailController.text, password: passwordController.text).then((value) async {
                                      final uid =  value.user?.uid.toString();
                                      final result =  await ref.read(userAuthProvider.notifier).validUser(uid: uid ?? "");
                                      if(result) {
                                       Navigator.pushNamed(context, AppRoutes.homeScreen,);
                                       Fluttertoast.showToast(msg: "User login successfully");
                                      }
                                      else {
                                       Fluttertoast.showToast(msg: "Your are not a User");
                                     }
                                  }).catchError((e){
                                    log("error  -----> $e");
                                    Fluttertoast.showToast(msg: "Email or Password is incorrect." );
                                  }).whenComplete((){
                                    isLoading.value = false;
                                  });
                                } else {
                                  ref.read(sellerAuthProvider.notifier).loginWithEmailAndPassword(
                                      email: emailController.text, password: passwordController.text).then((value) async {
                                    final uid =  value.user?.uid.toString();
                                    final result =  await ref.read(sellerAuthProvider.notifier).validSeller(uid: uid ?? "");
                                    if(result) {
                                      Navigator.pushNamed(context, AppRoutes.sellerHomeScreen,);
                                      Fluttertoast.showToast(msg: "User login successfully");
                                    }
                                    else {
                                      Fluttertoast.showToast(msg: "Your are not a Seller");
                                    }
                                  }).catchError((e){
                                    log("error -----> $e");
                                    // Fluttertoast.showToast(msg: "Email or Password is incorrect.");
                                  }).whenComplete((){
                                    isLoading.value = false;
                                  });
                                }
                              }
                            },
                            child: ValueListenableBuilder(
                              valueListenable: isLoading,
                              builder: (context, value, child) {
                                return Container(
                                  alignment: Alignment.center,
                                  height: 55,
                                  width: 200,
                                  decoration: BoxDecoration(color:ConstantColors.pinkAccentShade200, borderRadius: BorderRadius.circular(40)),
                                  child: value ? const CircularProgressIndicator(color: ConstantColors.white,) : Text(
                                    "Login",
                                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.signUpScreen,arguments: false);
                            },
                            child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2,color: ConstantColors.grey),

                                    children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2,
                                      color:ConstantColors.pinkAccentShade200),

                                )
                              ]
                            )),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          args == true ?  GestureDetector(
                              onTap: (){
                                Navigator.pushReplacementNamed(context, AppRoutes.loginScreen,);
                              },
                              child: Text(
                                "Login as a Customer",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.pinkAccentShade200),
                              ), )
                              : GestureDetector(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen,arguments: true);
                            },
                            child: Text(
                              "Login as a Seller",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.pinkAccentShade200),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

}


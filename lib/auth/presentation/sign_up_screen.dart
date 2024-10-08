import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:ecommerce_app/auth/controller/seller_auth.dart';
import 'package:ecommerce_app/auth/controller/user_auth.dart';
import 'package:ecommerce_app/common/linear_gradiant.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/custom_textfield.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments as bool;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final usernameController = useTextEditingController();
    final mobileNoController = useTextEditingController();
    final isObsureText = useValueNotifier(true);
    final isLoading = useValueNotifier(false);
    final formKey = GlobalKey<FormState>();
    final selectedCountry = useState("91");
    final phoneLength = useState(10);

    return Scaffold(
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
              "Sign Up",
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
                  padding: const EdgeInsets.only(right: 18.0, left: 18.0, top: 40, bottom: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: usernameController,
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person),
                          errorText: 'username',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          errorText: 'email',
                        ),
                        if (args)
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: mobileNoController,
                                labelText: 'Mobile No.',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: GestureDetector(
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          showPhoneCode: true,
                                          useSafeArea: true,
                                          countryListTheme: CountryListThemeData(
                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                              borderRadius: BorderRadius.circular(10),
                                              flagSize: 25.0,
                                              bottomSheetHeight: 600,
                                              inputDecoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.all(8),
                                                  hintText: "Search",
                                                  hintStyle: TextStyle(fontSize: 18),
                                                  prefixIcon: const Icon(
                                                    Icons.search,
                                                  ),
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                                          onSelect: (Country country) {
                                            log("selected country --> ${country.phoneCode} and ${country.example.length}");
                                            selectedCountry.value = country.phoneCode;
                                            phoneLength.value = country.example.length;
                                          },
                                        );
                                      },
                                      child: Text(
                                        "+${selectedCountry.value}",
                                        style: TextStyle(color: ConstantColors.black, fontWeight: FontWeight.w600, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                                errorText: 'Mobile No.',
                              ),
                            ],
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
                              prefixIcon: const Icon(Icons.lock_outline),
                              errorText: 'password',
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    isObsureText.value = !isObsureText.value;
                                  },
                                  child: Icon(value ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
                              obsureText: value,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        GestureDetector(
                          onTap: ()  {
                            if (formKey.currentState!.validate()) {
                              isLoading.value = true;
                              if (!args) {
                                 ref
                                    .read(userAuthProvider.notifier)
                                    .signUpWithEmailAndPassword(
                                    email: emailController.text, password: passwordController.text, userName: usernameController.text)
                                    .then((value) {
                                      if(value){
                                        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                                      }
                                }).catchError((e){
                                 }).whenComplete(() {
                                  isLoading.value = false;
                                });
                              } else {
                                ref
                                    .read(sellerAuthProvider.notifier)
                                    .signUpWithEmailAndPassword(
                                    email: emailController.text, password: passwordController.text, userName: usernameController.text, mobileNo: "+${selectedCountry.value+mobileNoController.text}")
                                    .then((value) {
                                      if(value){
                                        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen,arguments: true);
                                      }
                                }).catchError((e){
                                }).whenComplete(() {
                                  isLoading.value = false;
                                });
                              }
                            }
                          },
                          child: ValueListenableBuilder(
                            valueListenable: isLoading,
                            builder: (BuildContext context, bool value, Widget? child) {
                              return Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: 200,
                                decoration: BoxDecoration(color: ConstantColors.pinkAccentShade200, borderRadius: BorderRadius.circular(40)),
                                child: value
                                    ? const CircularProgressIndicator(
                                        color: ConstantColors.white,
                                      )
                                    : Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
                                      ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.loginScreen);
                          },
                          child: RichText(
                              text: TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                      fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.grey),
                                  children: [
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                      fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.pinkAccentShade200),
                                )
                              ])),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        args
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, AppRoutes.signUpScreen, arguments: false);
                                },
                                child: Text(
                                  "Sign Up as a Customer",
                                  style: TextStyle(
                                      fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.pinkAccentShade200),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, AppRoutes.signUpScreen, arguments: true);
                                },
                                child: Text(
                                  "Sign Up as a Seller",
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
    );
  }
}

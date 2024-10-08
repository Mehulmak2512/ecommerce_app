import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_app/common/linear_gradiant.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/splash_service/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    SplashServices splashServices = SplashServices();
    useEffect(() {
       splashServices.isLogin(context);
      return;
    },[]);

    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: linearGradient()),
      child: Center(
          child: AnimatedTextKit(
              animatedTexts: [
        WavyAnimatedText(
          "My Shop",
          textStyle: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: ConstantColors.white
          )
        ),
      ],
            repeatForever: false,
          )),
    ));
  }
}

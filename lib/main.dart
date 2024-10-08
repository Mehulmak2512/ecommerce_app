import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:ecommerce_app/common/no_internet_view.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/notification_service/notification_service.dart';
import 'package:ecommerce_app/practice/screens/practice.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/utility/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // configLoading();
  // NotificationService().initializeNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
        app: GetMaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "SpaceGrotesk",
        appBarTheme:
            const AppBarTheme(backgroundColor: ConstantColors.scaffoldBackgroundGreyShade100, iconTheme: IconThemeData(color: ConstantColors.white)),
        scaffoldBackgroundColor: ConstantColors.scaffoldBackgroundGreyShade100,
        colorScheme: ColorScheme.fromSeed(seedColor: ConstantColors.pinkAccentShade200),
        useMaterial3: true,
      ),
      routes: AppRoutes.routes,
      // initialRoute: AppRoutes.splash,
      home:  PaginateList( ),
      builder: EasyLoading.init(
        builder: (context, child) => ConnectivityWidgetWrapper(
          child: child ?? const SizedBox(),
          offlineWidget: NoInternetView(),
          disableInteraction: true,
        ),
      ),
    ));
  }
}
  

import 'package:ecommerce_app/auth/presentation/login_screen.dart';
import 'package:ecommerce_app/auth/presentation/sign_up_screen.dart';
import 'package:ecommerce_app/screens/user/presentation/home_tab/home_tab_screen.dart';
import 'package:ecommerce_app/screens/user/presentation/order_tab/order_tab_screen.dart';
import 'package:ecommerce_app/screens/user/presentation/widgets/order_items_list_screen.dart';
import 'package:ecommerce_app/splash_service/splash_screen.dart';
import 'package:flutter/material.dart';
import '../screens/user/presentation/cart_tab/cart_tab_screen.dart';
import '../screens/user/presentation/favorite_tab/favorite_tab_screen.dart';
import '../screens/user/presentation/home_screen.dart';
import '../screens/seller/seller_home_screen.dart';
import '../screens/seller/presentation/add_product_screen.dart';

class AppRoutes {

  static const String splash = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String homeScreen = '/homeScreen';
  static const String addProductScreen = '/addProductScreen';
  static const String favoriteScreen = '/favoriteScreen';
  static const String cartScreen = '/cartScreen';
  static const String orderScreen = '/orderScreen';
  static const String orderItemListScreen = '/orderItemListScreen';
  static const String homeTabScreen = '/homeTabScreen';
  static const String sellerHomeScreen = '/sellerHomeScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashScreen(),
    loginScreen: (context) => const LoginScreen(),
    signUpScreen: (context) => const SignUpScreen(),
    homeScreen: (context) => const HomeScreen(),
    addProductScreen: (context) => const AddProductScreen(),
    homeTabScreen: (context) => const HomeTabScreen(),
    favoriteScreen: (context) => const FavoriteScreen(),
    cartScreen: (context) => const CartScreen(),
    orderScreen: (context) => const OrderScreen(),
    orderItemListScreen: (context) => const OrderItemListScreen(),
    sellerHomeScreen: (context) => const SellerHomeScreen(),
  };
}

import 'dart:developer';

import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/common/linear_gradiant.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/screens/user/presentation/drawer_model.dart';
import 'package:ecommerce_app/screens/user/presentation/favorite_tab/favorite_tab_screen.dart';
import 'package:ecommerce_app/screens/user/presentation/home_tab/home_tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_tab/order_tab_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final args = ModalRoute.of(context)!.settings.arguments as int?;
    final currentIndex = useState(args ?? 0);
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? "";


    List<DrawerList> drawerList = [
      DrawerList(text: "Home", iconData: Icons.home_outlined),
      DrawerList(text: "Favorite", iconData: Icons.favorite_border),
      DrawerList(text: "Order", iconData: Icons.shopping_bag_outlined),
      DrawerList(text: "Log Out", iconData: Icons.logout),
    ];

    final screens = [
      const HomeTabScreen(),
      const FavoriteScreen(),
      // const CartScreen(),
      const OrderScreen(),
    ];

    return Scaffold(
      drawer: currentIndex.value == 0
          ? Drawer(

        backgroundColor: ConstantColors.scaffoldBackgroundGreyShade100,
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      gradient: linearGradient(),
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(60))
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person,size: 60,color: ConstantColors.black,),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          userName,
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          FirebaseAuth.instance.currentUser?.email.toString() ?? "",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                    Expanded(
                        child: ListView.builder(
                          itemCount: drawerList.length,
                          itemBuilder: (context, index) {
                          return AnimationConfiguration.synchronized(
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: 200,
                              verticalOffset: -50,
                              child: FadeInAnimation(
                                child: ListTile(
                                  leading:   Icon(drawerList[index].iconData,color: ConstantColors.black,),
                                  title: Text(drawerList[index].text,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),
                                  onTap: (){
                                    if(index == 0){
                                      Navigator.pop(context);
                                    }else if(index == 1){
                                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false,arguments: 1);
                                    }
                                    else if(index == 2){
                                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false,arguments: 2);
                                    }

                                    else if(index == 3){
                                      FirebaseAuth.instance.signOut().then((value) async {
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        preferences.remove("uId");
                                        preferences.remove("isUser");
                                        log("uId --> and ${preferences.getString("uId")} isUser ---> ${preferences.getString("isUser")}");
                                      },);
                                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen, (route) => false,);
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },),
                      )
                ],
              ),
            )
          : null,
      appBar: currentIndex.value == 0
          ? AppBar(
              title: Text(
                "Hello, $userName....",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
              ),
              flexibleSpace: const CustomAppBarBackground(),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, AppRoutes.cartScreen);
          }, icon: const Icon(Icons.shopping_cart_outlined,size: 28,)),
          const SizedBox(width: 10,),

        ],
      )
          : null,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          screens[currentIndex.value],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                  onTap: (value) {
                    currentIndex.value = value;
                  },
                  currentIndex: currentIndex.value,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: ConstantColors.pinkAccentShade200,
                  elevation: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedIconTheme: const IconThemeData(color: ConstantColors.white, size: 32),
                  unselectedIconTheme: const IconThemeData(color: ConstantColors.white, size: 25),
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite_border,
                        ),
                        activeIcon: Icon(Icons.favorite),
                        label: "Favorite"),
                    // BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart), label: "Cart"),
                    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), activeIcon: Icon(Icons.shopping_bag), label: "Shopping Bag"),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

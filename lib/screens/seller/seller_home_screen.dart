import 'dart:developer';

import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/common/linear_gradiant.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/screens/seller/controller/seller_dashboard_controller.dart';
import 'package:ecommerce_app/screens/user/presentation/drawer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SellerHomeScreen extends HookConsumerWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<DrawerList> drawerList = [
      DrawerList(text: "Home", iconData: Icons.home_outlined),
      DrawerList(text: "Log Out", iconData: Icons.logout),
    ];
    final userName = FirebaseAuth.instance.currentUser?.displayName ?? "";

    final allProducts = ref.watch(sellerDashBoardControllerProvider);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Hello, $userName....",
            style: GoogleFonts.spaceGrotesk(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
          ),
          flexibleSpace: const CustomAppBarBackground()),
      drawer: Drawer(
        backgroundColor: ConstantColors.scaffoldBackgroundGreyShade100,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(gradient: linearGradient(), borderRadius: const BorderRadius.only(bottomRight: Radius.circular(60))),
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: ConstantColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userName,
                    style: GoogleFonts.spaceGrotesk(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser?.email.toString() ?? "",
                    style: GoogleFonts.spaceGrotesk(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: drawerList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      drawerList[index].iconData,
                      color: ConstantColors.black,
                    ),
                    title: Text(
                      drawerList[index].text,
                      style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    onTap: () {
                      if (index == 0) {
                        Navigator.pop(context);
                      }else if (index == 1) {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen, (route) => false, arguments: true);
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      body: allProducts.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
                child: Text(
              "No Data Found",
              style:
                  GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
            ));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: data.length,
              itemBuilder: (context, index) {


                final item = data[index];

                return Stack(
                  children: [
                    Card(
                      elevation: 2,
                      color: ConstantColors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ConstantColors.grey,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                image: DecorationImage(image: NetworkImage(item["image_url"].toString()), fit: BoxFit.cover)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["name"].toString(),
                                      style: GoogleFonts.spaceGrotesk(
                                          fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                                    ),
                                    Text(
                                      "Quantity : ${item["quantity"].toString()}",
                                      style: GoogleFonts.spaceGrotesk(
                                          fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                                    ),
                                    Text(
                                      "Sell Product : ${item["sell_product"].toString()}",
                                      style: GoogleFonts.spaceGrotesk(
                                          fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                                    ),
                                  ],
                                ),
                                Text(
                                  "₹ ${item["price"].toString()}",
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 10),
                        child: PopupMenuButton(
                          position: PopupMenuPosition.under,
                          offset: Offset(0, 5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          onSelected: (value) {
                            if (value == "update") {
                              Navigator.pushNamed(context, AppRoutes.addProductScreen, arguments: {
                                "id": item["id"].toString(),
                                "name": item["name"].toString(),
                                "price": item["price"].toString(),
                                "quantity": item["quantity"].toString(),
                                "image_url": item["image_url"].toString()
                              });
                            } else if (value == "delete") {
                              ref.read(sellerDashBoardControllerProvider.notifier).deleteProduct(docId: item["id"].toString());
                            }
                          },
                          style: ButtonStyle(
                            iconColor: WidgetStateProperty.all(ConstantColors.white),
                            backgroundColor: WidgetStateProperty.all(ConstantColors.pinkAccentShade200),
                            animationDuration: Duration(milliseconds: 700),
                          ),
                          color: ConstantColors.white,
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                value: "update",
                                child: Text("Update",
                                    style: GoogleFonts.spaceGrotesk(color: ConstantColors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                              ),
                              PopupMenuItem(
                                value: "delete",
                                child: Text("Delete",
                                    style: GoogleFonts.spaceGrotesk(color: ConstantColors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                              ),
                            ];
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
            );
          }
        },
        error: (error, stackTrace) {
          log("$error");
          return const Center(child: Text("No Data Found"));
        },
        loading: () => const Center(
            child: CircularProgressIndicator(
          color: ConstantColors.pinkAccentShade200,
        )),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.pinkAccentShade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addProductScreen);
        },
        child:  Text("Add Product",style: GoogleFonts.spaceGrotesk(color: ConstantColors.white,fontSize: 18),)
      ),
    );
  }
}

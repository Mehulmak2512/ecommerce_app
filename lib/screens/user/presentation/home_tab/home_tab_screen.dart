import 'dart:developer';

import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/screens/user/controller/cart_provider.dart';
import 'package:ecommerce_app/screens/user/controller/favorite_list_provider.dart';
import 'package:ecommerce_app/screens/user/controller/user_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeTabScreen extends HookConsumerWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(userDashboardControllerProvider);

    return Scaffold(
      body: allProducts.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
                child: Text(
              "No Data Found",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
            ));
          } else {
            return GridView.builder(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 82),
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, mainAxisExtent: 250),
                itemBuilder: (context, index) {
                  final item = data[index];

                  // log("quantity --> ${item["quantity"]}");
                  // final isFav = ref.watch(favoriteListProvider
                  //     .select((data) => data.value?.docs.any((element) => element.data()["product_id"] == item.data()["product_id"]) ?? false));

                  // final isFav = ref.watch(
                  //   favoriteListProvider.select(
                  //     (data) {
                  //       var where = data.whenData((data)=> data.where((element) => element["product_id"] == item["product_id"]).toList());
                  //       return (where.value?.isEmpty ?? false) ? null : where.value?.first["doc_id"];
                  //       // return (where?.isEmpty ?? false) ? null : where?.first["doc_id"];
                  //     },
                  //   ),
                  // );

                  // log(" id  --> ${isFav}");
                  // log(" id  --> ${item["product_id"]}");

                  return AnimationConfiguration.synchronized(
                    duration: const Duration(milliseconds: 650),
                    child: FadeInAnimation(
                      child: Stack(
                        children: [
                          Card(
                            elevation: 2,
                            color: ConstantColors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ConstantColors.grey,
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                      image: DecorationImage(image: NetworkImage(item["image_url"].toString()), fit: BoxFit.cover)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["name"].toString(),
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                                      ),
                                      Text(
                                        "₹ ${item["price"].toString()}",
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      item["quantity"] > 0
                                          ? Consumer(
                                              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                                final isAdd = ref.watch(cartProvider
                                                    .select((data) => data.value?.any((element) => element["product_id"] == item["id"]) ?? false));
                                                return ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      fixedSize: const Size(150, 20),
                                                    ),
                                                    onPressed: () {
                                                      if (!isAdd) {
                                                        ref.read(cartProvider.notifier).addCart(map: {
                                                          "name": item["name"].toString(),
                                                          "image_url": item["image_url"].toString(),
                                                          "price": item["price"].toString(),
                                                          "available": item["quantity"],
                                                          "product_id": item["id"].toString(),
                                                          "sell_product": item["sell_product"],
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      isAdd ? "Added to cart" : "Add to cart",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1.1, color: ConstantColors.black),
                                                    ));
                                              },
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(top: 8),
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                                              decoration: BoxDecoration(
                                                color: ConstantColors.pinkAccentShade200,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                "Out of stock",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.1,
                                                  color: ConstantColors.white,
                                                ),
                                              ),
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
                              padding: const EdgeInsets.only(top: 10, right: 10),
                              child: Consumer(
                                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                  final isFav = ref.watch(favProductIdProvider.select((data) {
                                    return data?.contains(item["id"]);
                                  }));

                                  return GestureDetector(
                                    onTap: () {
                                      if (isFav == false || isFav == null) {
                                        ref.read(favProductIdProvider.notifier).addFavoriteProduct(pId: item["id"].toString());
                                      } else {
                                        ref.read(favProductIdProvider.notifier).removeProduct(pId: item["id"].toString());
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: ConstantColors.pinkAccentShade200,
                                      child: Icon(
                                        isFav ?? false ? Icons.favorite : Icons.favorite_border,
                                        color: ConstantColors.white,
                                      ),
                                    ),
                                  );
                                },
                                // child: ,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
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
    );
  }
}

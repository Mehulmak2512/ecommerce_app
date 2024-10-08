import 'dart:developer';
import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/screens/user/controller/cart_provider.dart';
import 'package:ecommerce_app/screens/user/controller/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartScreen extends HookConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ValueNotifier<int>(0);
    final cartProduct = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
        ),
        centerTitle: true,
        flexibleSpace: const CustomAppBarBackground(),
      ),
      body: cartProduct.when(
        data: (data) {
          if (data.isEmpty) {
            return Center(
                child: Text(
              "No Data Found",
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
            ));
          } else {
            List<int> totalPrice = data.map(
              (e) {
                return int.parse(e["price"]) * int.parse(e["quantity"].toString());
              },
            ).toList();

            total.value = totalPrice.fold(
              total.value,
              (previousValue, element) => (previousValue + element),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      int quantity = item["quantity"];
                      int available = item["available"];

                      int subtotalPrice = int.parse(item["price"]) * quantity;

                      return SizedBox(
                        width: double.infinity,
                        height: 130,
                        child: Card(
                          color: ConstantColors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Container(
                                height: 120,
                                width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(image: NetworkImage(item["image_url"].toString()), fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item["name"].toString().toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: Colors.black),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        quantity == 1
                                            ? const SizedBox()
                                            : Text(
                                                "₹ ${item["price"].toString()} ",
                                                style: TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: Colors.grey),
                                              ),
                                        Text(
                                          "₹ $subtotalPrice",
                                          style:TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: Colors.grey.shade300,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                            onPressed: () {
                                              // log("item id --${item["id"]}");
                                              if (quantity <= 1) {
                                                ref.read(cartProvider.notifier).removeCart(id: item["id"].toString());
                                              } else {
                                                ref.read(cartProvider.notifier).updateCart(id: item["id"].toString(), inc: false);
                                              }
                                            },
                                            icon: const Icon(Icons.remove)),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        IconButton(
                                            style: IconButton.styleFrom(
                                                backgroundColor: Colors.grey.shade300,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                            onPressed: () {
                                              if (quantity < available) {
                                                ref.read(cartProvider.notifier).updateCart(id: item["id"].toString(), inc: true);
                                              } else {
                                                Fluttertoast.showToast(msg: "no more items available");
                                              }
                                            },
                                            icon: const Icon(Icons.add)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: ConstantColors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                            child: ValueListenableBuilder(
                              valueListenable: total,
                              builder: (context, value, child) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Total Price : ₹ ",
                                        style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: "$value",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1.1,
                                                color: ConstantColors.pinkAccentShade200),
                                          )
                                        ]),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(orderProvider.notifier).placeOrder(data: data, totalPrice: total.value, productQuantity: data.length);
                          Navigator.pushReplacementNamed(context, AppRoutes.homeScreen, arguments: 2);
                        },
                        child: Card(
                          color: ConstantColors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Place Order",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
    );
  }
}

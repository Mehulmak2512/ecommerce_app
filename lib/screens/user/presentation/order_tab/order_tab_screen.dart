import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:ecommerce_app/screens/user/controller/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class OrderScreen extends HookConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My Orders",
          style: GoogleFonts.spaceGrotesk(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
        ),
        centerTitle: true,
        flexibleSpace: const CustomAppBarBackground(),
      ),
      body: orders.when(
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
              itemCount: data.length,
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 82),
              itemBuilder: (context, index) {
                final item = data[index];

                Timestamp stamp = item["time"];
                DateTime date = stamp.toDate();
                final orderDateTime = DateFormat.yMMMd().add_jm().format(date);

                // log("date time  -- ${DateFormat.yMMMd().add_jm().format(date)  }");

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.orderItemListScreen,
                      arguments: {
                        "order_id": item["id"].toString(),
                        "order_no": index + 1,
                        "amount": item["total_price"],
                        "date_time": orderDateTime,
                        "product": item["product_quantity"]
                      },
                    );
                  },
                  child: AnimationConfiguration.synchronized(
                    duration: const Duration(milliseconds: 650),
                    child: SlideAnimation(
                      verticalOffset: 40,
                      child: FadeInAnimation(
                        child: SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Card(
                            color: ConstantColors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Order No. : ${index + 1}",
                                              style: GoogleFonts.spaceGrotesk(
                                                  fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                                            ),
                                            Text(
                                              orderDateTime,
                                              style: GoogleFonts.spaceGrotesk(
                                                  fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.grey),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Amount : ₹${item["total_price"].toString()}",
                                              style: GoogleFonts.spaceGrotesk(
                                                  fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                                            ),
                                            Text(
                                              "Product : ${item["product_quantity"].toString()}",
                                              style: GoogleFonts.spaceGrotesk(
                                                  fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
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
    );
  }
}

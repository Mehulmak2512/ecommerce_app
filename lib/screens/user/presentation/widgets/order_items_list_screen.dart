import 'dart:developer';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/screens/user/controller/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderItemListScreen extends HookConsumerWidget {
  const OrderItemListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final orderItems = ref.watch(orderItemProvider(args["order_id"]));

    final quantity = ValueNotifier<int>(0);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ConstantColors.black),
      ),
      body: orderItems.when(
        data: (data) {
          // log("data is -- $data");

          if (data.isEmpty) {
            return Center(
                child: Text(
              "No Data Found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
            ));
          } else {
            List<int> totalQuantity = data.map(
              (e) {
                return int.parse(e["quantity"].toString());
              },
            ).toList();

            quantity.value = totalQuantity.fold(
              quantity.value,
              (previousValue, element) => (previousValue + element),
            );

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: ConstantColors.white, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonText(text: "Oder No. :",),
                          CommonText(text: args["order_no"].toString(),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonText(text: "Time :",),
                          CommonText(text: args["date_time"].toString(),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonText(text: "Products :",),
                          CommonText(text: args["product"].toString(),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonText(text: "Quantity :",),
                          CommonText(text:quantity.value.toString()),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonText(text: "Amount :",),
                          CommonText(text: "₹${args["amount"].toString()}"),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      final item = data[index];
                      int quantity = item["quantity"];
                      int subtotalPrice = int.parse(item["price"]) * quantity;

                      return SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: Card(
                          color: ConstantColors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Container(
                                width: 85,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(image: NetworkImage(item["image_url"].toString()), fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonText(text:item["name"].toString(), ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              quantity == 1
                                                  ? const SizedBox()
                                                  : Text(
                                                      "₹${item["price"].toString()} ",
                                                      style: TextStyle(
                                                          fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.grey),
                                                    ),
                                              Text(
                                                "₹$subtotalPrice",
                                                // "Price : ₹${item["price"].toString()}",
                                                style: TextStyle(
                                                    fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Quantity : ${item["quantity"].toString()}",
                                            style: TextStyle(
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
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                  ),
                ),
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

class CommonText extends StatelessWidget {
  final String text;
  const CommonText({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
    );
  }
}

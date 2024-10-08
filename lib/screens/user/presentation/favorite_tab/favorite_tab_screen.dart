import 'dart:developer';

import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/screens/user/controller/favorite_list_provider.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteScreen extends HookConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final favProduct =  ref.watch(favoriteProductProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My Favorites",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: ConstantColors.white),
        ),
        centerTitle: true,
        flexibleSpace: const CustomAppBarBackground(),
      ),
      body: favProduct.when(data: (data) {
        if(data.isEmpty){
          return Center(
            child:   Text(
              "No Data Found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
            ),
          );
        }
        return ListView.separated(
          itemCount: data.length,
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 82),
          itemBuilder: (context, index) {

            final item = data[index];

            return Entry.all(
              delay: const Duration(milliseconds: 150),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              opacity: 0.3,
              scale: 0.6,
              xOffset: 5,
              yOffset: 10,
              child: Card(
                color: ConstantColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(image: NetworkImage(item["image_url"].toString()),fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          item["name"].toString(),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
                        ),
                        Text(
                          "₹ ${item["price"].toString()}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.pinkAccentShade200),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer(
                        builder: (BuildContext context, WidgetRef ref, Widget? child) {
                          return GestureDetector(
                            onTap: (){
                              ref.read(favoriteProductProvider.notifier).removeProduct(pId: item["id"].toString());

                              ref.read(favProductIdProvider.notifier).removeProduct(
                                  pId: item["id"].toString()
                              );

                            },
                            child: const CircleAvatar(
                              radius: 18 ,
                              backgroundColor: ConstantColors.grey,
                              child: Icon(
                                Icons.close,
                                color: ConstantColors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    )
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
        );
      },
        error: (error, stackTrace) {
          log("error : $error");
          return Center(
            child:   Text(
              "No Data Found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.1, color: ConstantColors.black),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: ConstantColors.pinkAccentShade200,),),),
    );
  }
}

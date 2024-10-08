import 'dart:developer';

import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageViewExample extends HookConsumerWidget {
  const PageViewExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final tabController = useTabController(initialLength: 3);
    final currentPageIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("PageView"),
        centerTitle: true,
        actions: [
          CustomButton(text: "Skip", onTap: (){
            currentPageIndex.value = (tabController.length - 1);
            tabController.index = currentPageIndex.value;
            log(" current Index -- ${currentPageIndex.value}");
            pageController.animateToPage(currentPageIndex.value, duration: const Duration(microseconds: 100), curve: Curves.bounceOut);
          }),
          const SizedBox(width: 15,),

        ],
        flexibleSpace: const CustomAppBarBackground(),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              tabController.index = value;
              currentPageIndex.value = value;
            },
            children: const [
              Center(
                child: Text('First Page'),
              ),
              Center(
                child: Text('Second Page'),
              ),
              Center(
                child: Text('Third Page'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPageIndex.value == 0 ? const SizedBox(
                  height: 35,
                  width: 90,
                ) : CustomButton(
                  text: "Previous",
                  onTap: () {
                    currentPageIndex.value -= 1;
                    tabController.index = currentPageIndex.value;
                    log("current Index -- ${currentPageIndex.value}");
                    pageController.animateToPage(currentPageIndex.value, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                ),
                TabPageSelector(
                  controller: tabController,
                  indicatorSize: 15,
                  selectedColor: ConstantColors.pinkAccentShade200,
                  color: ConstantColors.grey,
                  borderStyle: BorderStyle.none,
                ),
                CustomButton(
                  text: "Next",
                  onTap: () {
                    if (currentPageIndex.value == (tabController.length - 1)) {
                      return;
                    }
                    currentPageIndex.value += 1;
                    tabController.index = currentPageIndex.value;
                    log(" current Index -- ${currentPageIndex.value}");
                    pageController.animateToPage(currentPageIndex.value, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 35,
        width: 90,
        decoration: BoxDecoration(color: ConstantColors.pinkAccentShade200, borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}

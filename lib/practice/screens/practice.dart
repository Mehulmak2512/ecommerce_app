import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:ecommerce_app/common/custom_appbar_background.dart';
import 'package:ecommerce_app/constants/constant_colors.dart';
import 'package:ecommerce_app/practice/controller/controller.dart';
import 'package:ecommerce_app/practice/model/unknown_model_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loadmore_listview/loadmore_listview.dart';

import '../controller/product_controller.dart';

class EasyLoadingPractice extends StatefulWidget {
  EasyLoadingPractice({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _EasyLoadingPracticeState createState() => _EasyLoadingPracticeState();
}

class _EasyLoadingPracticeState extends State<EasyLoadingPractice> {
  Timer? _timer;
  late double _progress;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(widget.title ?? 'Easy Loading'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const TextField(),
              Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: const Text('open test page'),
                    onPressed: () {
                      _timer?.cancel();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => TestPage(),
                      //   ),
                      // );
                    },
                  ),
                  TextButton(
                    child: const Text('dismiss'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.dismiss();
                      print('EasyLoading dismiss');
                    },
                  ),
                  TextButton(
                    child: const Text('show'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      print('EasyLoading show');
                    },
                  ),
                  TextButton(
                    child: const Text('showToast'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showToast(
                        'Toast',
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('showSuccess'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.showSuccess('Great Success!');
                      print('EasyLoading showSuccess');
                    },
                  ),
                  TextButton(
                    child: const Text('showError'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showError('Failed with Error');
                    },
                  ),
                  TextButton(
                    child: const Text('showInfo'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showInfo('Useful Information.');
                    },
                  ),
                  TextButton(
                    child: const Text('showProgress'),
                    onPressed: () {
                      _progress = 0;
                      _timer?.cancel();
                      _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
                        EasyLoading.showProgress(_progress, status: '${(_progress * 100).toStringAsFixed(0)}%');
                        _progress += 0.03;

                        if (_progress >= 1) {
                          _timer?.cancel();
                          EasyLoading.dismiss();
                        }
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('Style'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingStyle>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingStyle.dark: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('dark'),
                          ),
                          EasyLoadingStyle.light: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('light'),
                          ),
                          EasyLoadingStyle.custom: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.loadingStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('MaskType'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingMaskType>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingMaskType.none: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('none'),
                          ),
                          EasyLoadingMaskType.clear: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('clear'),
                          ),
                          EasyLoadingMaskType.black: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('black'),
                          ),
                          EasyLoadingMaskType.custom: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.maskType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('Toast Positon'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingToastPosition>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingToastPosition.top: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('top'),
                          ),
                          EasyLoadingToastPosition.center: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('center'),
                          ),
                          EasyLoadingToastPosition.bottom: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('bottom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.toastPosition = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    const Text('Animation Style'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingAnimationStyle>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingAnimationStyle.opacity: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('opacity'),
                          ),
                          EasyLoadingAnimationStyle.offset: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('offset'),
                          ),
                          EasyLoadingAnimationStyle.scale: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('scale'),
                          ),
                          EasyLoadingAnimationStyle.custom: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.animationStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 50.0,
                ),
                child: Column(
                  children: <Widget>[
                    const Text('IndicatorType(total: 23)'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingIndicatorType>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingIndicatorType.circle: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('circle'),
                          ),
                          EasyLoadingIndicatorType.wave: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('wave'),
                          ),
                          EasyLoadingIndicatorType.ring: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('ring'),
                          ),
                          EasyLoadingIndicatorType.pulse: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('pulse'),
                          ),
                          EasyLoadingIndicatorType.cubeGrid: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('cubeGrid'),
                          ),
                          EasyLoadingIndicatorType.threeBounce: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('threeBounce'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.indicatorType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryPicker extends HookConsumerWidget {
  const CountryPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final selectedCountry = useState("91");
    final phoneLength = useState(10);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Practice",
          style: GoogleFonts.spaceGrotesk(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: const CustomAppBarBackground(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller,
                focusNode: focusNode,
                autovalidateMode: AutovalidateMode.always,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the Mobile no.";
                  } else if (value.length != phoneLength.value) {
                    return "Please enter the valid Mobile no.";
                  }
                  return null;
                },
                style: GoogleFonts.spaceGrotesk(color: ConstantColors.black, fontWeight: FontWeight.bold),
                // obscureText: isObsureText.value,
                decoration: InputDecoration(
                  label: Text(
                    "Mobile No.",
                    style: GoogleFonts.spaceGrotesk(color: ConstantColors.grey, fontWeight: FontWeight.bold),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            useSafeArea: true,
                            countryListTheme: CountryListThemeData(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                borderRadius: BorderRadius.circular(10),
                                flagSize: 25.0,
                                bottomSheetHeight: 600,
                                inputDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8),
                                    hintText: "Search",
                                    hintStyle: GoogleFonts.spaceGrotesk(fontSize: 18),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                            onSelect: (Country country) {
                              log("selected country --> ${country.phoneCode} and ${country.example.length}");
                              selectedCountry.value = country.phoneCode;
                              phoneLength.value = country.example.length;
                            },
                          );
                        },
                        child: Text(
                          "+${selectedCountry.value}",
                          style: GoogleFonts.spaceGrotesk(color: ConstantColors.black, fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: ConstantColors.grey)),
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: ConstantColors.pinkAccent)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: ConstantColors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaginateListScreen extends HookConsumerWidget {
  const PaginateListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(unkonwnListProvider.notifier).getUnknown();
      });
      return;
    }, []);
    final hasMoreItem = useState(true);
    final page = useState(1);
    final controller = ref.watch(unkonwnListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pagination",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        if (controller == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.data?.isEmpty ?? true) {
          return const Text("No Data Found");
        }
        return LoadMoreListView.separated(
          loadMoreWidget: const Center(
            child: CircularProgressIndicator(),
          ),
          onLoadMore: () => onLoadMore(page, controller.totalPages, hasMoreItem, ref),
          hasMoreItem: hasMoreItem.value,
          itemCount: controller.data?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      controller.data?[index]?.name ?? " ",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      controller.data?[index]?.pantoneValue ?? " ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      controller.data?[index]?.year.toString() ?? " ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      controller.data?[index]?.color ?? " ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      controller.data?[index]?.id.toString() ?? " ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 20),
        );
      }),
    );
  }

  onLoadMore(ValueNotifier<int> page, int? totalPage, ValueNotifier<bool> hasMoreItem, WidgetRef ref) async {
    if (page.value < totalPage!) {
      page.value++;
      hasMoreItem.value = true;
      return await ref.read(unkonwnListProvider.notifier).getUnknown(page: page.value);
    } else {
      hasMoreItem.value = false;
      return null ;
    }
  }
}

class PaginateList extends StatelessWidget {
  final controller = Get.put(ProductController());

  PaginateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pagination",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Obx(
            () {
          if (controller.isLoading.value && controller.unknownList.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.unknownList.value?.data?.isEmpty ?? true) {
            return const Center(child: Text("No Data Found"));
          }

          return LoadMoreListView.separated(
            itemCount: controller.unknownList.value?.data?.length ?? 0,
            hasMoreItem: controller.hasMoreItems.value,
            // onLoadMore: () async => await controller.loadMore(),
            onLoadMore:() => controller.loadMore(),
            loadMoreWidget: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: CircularProgressIndicator(),
              ),
            ),
            itemBuilder: (context, index) {
              final item = controller.unknownList.value?.data?[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item?.name ?? "No Name"),
                      Text(item?.pantoneValue ?? "No Pantone Value"),
                      Text(item?.year.toString() ?? "No Year"),
                      Text(item?.color ?? "No Color"),
                      Text(item?.id.toString() ?? "No ID"),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          );
        },
      ),
    );
  }
}
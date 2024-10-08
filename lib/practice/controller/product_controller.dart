import 'dart:developer';
import 'package:ecommerce_app/practice/network/dio_client.dart';
import 'package:get/get.dart';
import '../model/unknown_model_entity.dart';

class ProductController extends GetxController {

  Rx<UnknownModelEntity?> unknownList = Rx<UnknownModelEntity?>(null);
  RxBool isLoading = false.obs;
  RxBool hasMoreItems = true.obs;
  RxInt page = 1.obs;
  RxInt totalPage = 1.obs;

  @override
  Future<void> onInit() async {
        await getUnknown();
        log("unknownList ---> ${unknownList.value?.data}");
        log("isLoading ---> ${isLoading.value}");
        log("hasMoreItems ---> ${hasMoreItems.value}");
        log("page ---> ${page.value}");
        log("totalPage ---> ${totalPage.value}");
        super.onInit();
  }
  Future<void> getUnknown() async {
    if (page.value == 1) {
      unknownList.value = null;
    }
    isLoading.value = true;
    try {
      final res = await DioClient().getUnknown({"page": page.value});

      if (page.value == 1) {
        unknownList.value = res;
        totalPage.value = res?.totalPages ?? 1;
      } else {
        unknownList.value = unknownList.value?.copyWith(
            data: [...unknownList.value?.data ?? [], ...res?.data ?? []]
        );
      }
    } catch (e) {
      log('Error: $e');
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> loadMore() async {
    if (page.value < totalPage.value && !isLoading.value) {
      page.value++;
      await getUnknown();
    } else {
      hasMoreItems.value = false;
    }
  }
}

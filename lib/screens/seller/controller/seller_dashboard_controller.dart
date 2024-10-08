import 'dart:io';

import 'package:ecommerce_app/screens/user/controller/user_dashboard_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/seller_product_repository.dart';

part 'seller_dashboard_controller.g.dart';

@riverpod
class SellerDashBoardController extends _$SellerDashBoardController {
  @override
  Future<List<Map<String, dynamic>>> build() {
    return getProductList();
  }

  SellerProductRepository sellerProductRepository = SellerProductRepository();

  Future<List<Map<String, dynamic>>> getProductList() {
    final allProducts = sellerProductRepository.allProducts();
    return allProducts;
  }

  Future<void> addProduct({required String name, required String price, required int quantity, required File? image}) async {
    await sellerProductRepository.addProduct(
      name: name,
      price: price,
      quantity: quantity,
      image: image,
    );
    state = AsyncData(await getProductList());
  }

  Future<void> updateProduct({required Map<String, dynamic> data, File? imageFile, String? imageUrl}) async {
    await sellerProductRepository.updateProduct(data: data, imageFile: imageFile, imageUrl: imageUrl).then(
      (value) {
        Fluttertoast.showToast(msg: "Product updated successfully");
      },
    ).catchError((e) {
      Fluttertoast.showToast(msg: "something went wrong");
    });
    state = AsyncData(await getProductList());
  }

  Future<void> deleteProduct({required String docId}) async {
    await sellerProductRepository.deleteProduct(docId: docId).then(
      (value) {
        Fluttertoast.showToast(msg: "Product deleted successfully");
      },
    ).catchError((e) {
      Fluttertoast.showToast(msg: "something went wrong");
    });
    state = AsyncData(state.value!.where((element) => element["id"] != docId).toList());
  }

  Future<void> updateQuantity({required List<Map<String, dynamic>> data}) async {
    List<Map<String, dynamic>> map = [];
    // log("data $data");
    data.forEach(
          (element) {
        final sellProduct = int.parse(element["sell_product"].toString()) + int.parse(element["quantity"].toString());
        final quantity = int.parse(element["available"].toString()) - int.parse(element["quantity"].toString());
        // log("available ${int.parse(element["available"].toString())}");
        // log("quantity ------ $quantity");
        // log("quantity ${element["quantity"].toString()}");
        map = [
          ...map,
          {
            "id": element["product_id"].toString(),
            "sell_product": sellProduct,
            "quantity": quantity,
          }
        ];
      },
    );
    SellerProductRepository sellerProductRepository = SellerProductRepository();
    await sellerProductRepository.updateProductQuantity(data: map);
    ref.read(userDashboardControllerProvider.notifier).getProductList();
  }

}




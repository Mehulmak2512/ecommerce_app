
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/user/repository/user_product_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class Cart extends _$Cart {
  @override
  FutureOr<List<Map<String, dynamic>>> build() async {
    return getCartList();
  }

  ProductRepository productRepository = ProductRepository();

  Future<List<Map<String, dynamic>>> getCartList() async {
    final allCartProducts = await productRepository.allCartProduct();
    allCartProducts.sort((a, b) => a["name"].compareTo(b["name"]));
    return allCartProducts;
  }

  Future<void> addCart({required Map<String,dynamic> map}) async {

    final uid = FirebaseAuth.instance.currentUser?.uid.toString();
    final docRef = FirebaseFirestore.instance.collection("cart").doc(uid).collection("cartItems").doc();
    // log("docId --- ${docRef.id}");
    final data = {
       ...map,
      "quantity": 1,
      "u_id": uid,
      "id": docRef.id,
    };
    await productRepository.addToCart(map: data);
    state.whenData((products) {
      state = AsyncData([...products, data]);
    });
  }

  Future<void> updateCart({required String id, required bool inc}) async {

    // log("id --> $id");
    await productRepository.updateProductQuantity(id: id, inc: inc);

    var data = state.whenData((data)=> data.where((element) => element["id"] == id));
    var product = data.value?.isEmpty ?? false ? null : data.value?.first;
    final cartData = {
      "name": product?["name"],
      "image_url": product?["image_url"],
      "price": product?["price"],
      "available": product?["available"],
      "sell_product": product?["sell_product"],
      "quantity": inc ?( product?["quantity"] + 1) : (product?["quantity"] -1 ) ,
      "u_id": product?["u_id"],
      "product_id": product?["product_id"],
      "id": id,
    };

    state = AsyncData(state.value!.where((element) => element["id"] != id).toList());

    state.whenData((products) {
      state = AsyncData([...products, cartData]);
      state.value?.sort((a, b) => a["name"].compareTo(b["name"]),);

    });

  }

  Future<void> removeCart({required String id}) async {
    await productRepository.removeFromCart(id: id);
    state = AsyncData(state.value!.where((element) => element["id"] != id).toList());
  }

  Future<void> deleteCart() async {
    await productRepository.deleteCart();
    state = const AsyncData([]);
  }

}

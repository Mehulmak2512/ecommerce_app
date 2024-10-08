import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRepository {
  final fireBaseFireStore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid.toString();

  ///   <--------- Products --------->   ///

  // Future<QuerySnapshot<Map<String, dynamic>>> allProducts() async => await fireBaseFireStore.collection("product").where("u_id",isEqualTo: uid).get();

  Future<List<Map<String, dynamic>>> allProducts() async {
    final favProduct = await fireBaseFireStore.collection("product").orderBy("name").get();
    return favProduct.docs.map((element) => element.data()).toList();
  }

  /// favorite productList from product collection

  Future<List<Map<String, dynamic>>> favoriteList(List<String> favProductId) async {
    final favProduct =
        await fireBaseFireStore.collection("product").where("u_id", isEqualTo: uid).where(FieldPath.documentId, whereIn: favProductId).get();
    return favProduct.docs.map((element) => element.data()).toList();
  }

  ///   <--------- Favorites --------->   ///

  Future<void> addToFavorite({required String name, required String price, required String image, required String productId}) async {
    final docRef = fireBaseFireStore.collection("favorite").doc();
    final data = {
      "name": name,
      "image_url": image,
      "price": price,
      "u_id": uid,
      "product_id": productId,
      "doc_id": docRef.id,
    };
    await docRef.set(data);
  }

  Future<List<Map<String, dynamic>>> allFavProducts() async {
    final favProduct = await fireBaseFireStore.collection("favorite").where("u_id", isEqualTo: uid).get();
    return favProduct.docs.map((element) => element.data()).toList();
  }

  Future<void> removeFromFavorite({required String docId}) async {
    await fireBaseFireStore.collection("favorite").doc(docId).delete();
  }

  ///   <--------- Carts --------->   ///

  Future<void> addToCart(
      {required Map<String,dynamic> map}) async {
    // log("docId --- $docId");
    final docRef = fireBaseFireStore.collection("cart").doc(uid).collection("cartItems").doc(map["id"].toString());
    await docRef.set(map);
  }

  Future<List<Map<String, dynamic>>> allCartProduct() async {
    final favProduct = await fireBaseFireStore.collection("cart").doc(uid).collection("cartItems").orderBy("name").get();
    // log("fav product -- ${favProduct.docs.map((e) => e.data(),) }");
    return favProduct.docs.map((element) => element.data()).toList();
  }

  Future<void> updateProductQuantity({required String id, required bool inc}) async {
    await fireBaseFireStore.collection("cart").doc(uid).collection("cartItems").doc(id).update({
      "quantity": FieldValue.increment(inc ? 1 : -1),
    });
  }

  Future<void> removeFromCart({required String id}) async {
    await fireBaseFireStore.collection("cart").doc(uid).collection("cartItems").doc(id).delete();
  }

  Future<void> deleteCart() async {
    final batch = fireBaseFireStore.batch();
    await fireBaseFireStore.collection("cart").doc(uid).collection("cartItems").get().then(
      (value) {
        value.docs.forEach((element) {
          batch.delete(element.reference);
        });
      },
    );
    batch.commit();
  }

  ///   <--------- Orders --------->   ///

  Future<void> placeOrder({required List<Map<String, dynamic>> data, required int totalPrice,required int productQuantity}) async {
    final batch = fireBaseFireStore.batch();
    final docRef = fireBaseFireStore.collection("orders").doc(uid).collection("order").doc();

    // log("data --$data");

    final product = {
      "total_price": totalPrice,
      "product_quantity": productQuantity,
      "u_id": uid,
      "time": DateTime.now(),
      "id": docRef.id,
    };
    docRef.set(product);
    data.forEach((product) {
      batch.set(docRef.collection("orderItems").doc(), product);
    });
    batch.commit();
  }

  Future<List<Map<String, dynamic>>> allOrders() async {

    final allOrders = await fireBaseFireStore.collection("orders").doc(uid).collection("order").orderBy("time").get();
    return allOrders.docs.map((element) => element.data()).toList();

    // List<Map<String, dynamic>>? allOrders;
    // await fireBaseFireStore.collection("orders").doc(uid).collection("order").get().then(
    //   (value) async {
    //       // log("allOrders is inner log--- ${value.docs.first.,}");
    //
    //     // for(final element in value.docs){
    //     //   final orders = await fireBaseFireStore.collection("orders").doc(uid).collection("order").doc(element.id).collection("orderItems").get();
    //     //   final listOrder = orders.docs.map((element) => element.data()).toList();
    //     //   allOrders = [...?allOrders, ...listOrder];
    //     //   log("allOrders is inner log--- ${allOrders}");
    //     // }
    //   },
    // );
    // log("allOrders is --- ${allOrders}");
  }


  Future<List<Map<String, dynamic>>> orderItems({required String orderId}) async {
    final orderItems = await fireBaseFireStore.collection("orders").doc(uid).collection("order").doc(orderId).collection("orderItems").orderBy("name").get();
    return orderItems.docs.map((element) => element.data()).toList();
  }
}

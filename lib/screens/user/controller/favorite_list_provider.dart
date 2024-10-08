import 'dart:developer';

import 'package:ecommerce_app/screens/user/repository/user_product_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite_list_provider.g.dart';


@riverpod
class FavoriteProduct extends _$FavoriteProduct {
  List<String> productId = [];
  @override
  Future<List<Map<String, dynamic>>> build() async {
    return getFavList();
  }
  Future<List<Map<String, dynamic>>> getFavList() async {
      productId =  ref.watch(favProductIdProvider) ?? [];
      // log("productId $productId");
      if(productId.isNotEmpty){
      ProductRepository productRepository = ProductRepository();
      final favProducts = await productRepository.favoriteList(productId);
      // log("fav list ---> ${favProducts.length}");
      return favProducts;
    }
    // log("fav list empty");
    return [];
  }
  Future<void> removeProduct({required String pId}) async {
    state = AsyncData(state.value!.where((element) => element["id"] != pId).toList());
  }
}

@riverpod
class FavProductId extends _$FavProductId {
  List<String>? favProductId;
  SharedPreferences? pref;
  @override
  List<String>? build()  {
   getFavId();
   // log("favProductId -- $favProductId");
   return favProductId ?? [];
  }

  Future<void> getFavId() async {
    pref = await SharedPreferences.getInstance();
    favProductId =   pref?.getStringList("favProductId");
    // log("favProductId -- $favProductId");
    state = favProductId;
  }

  Future<void> addFavoriteProduct({required String pId}) async {
    favProductId = [...?favProductId, pId];
    await pref?.setStringList("favProductId", favProductId!);
    Fluttertoast.showToast(msg: "added to favorite");
    state = favProductId;

  }

  Future<void> removeProduct({required String pId}) async {
    log("pId --- $pId");
    favProductId = favProductId?.where((element) => element != pId).toList();
    await pref?.setStringList("favProductId", favProductId!);
    Fluttertoast.showToast(msg: "remove from favorite");
    state = favProductId;
  }



// Future<List<Map<String, dynamic>>> getFavList() {
//    ProductRepository productRepository = ProductRepository();
//   final favProducts = productRepository.allFavProducts();
//   return favProducts;
// }
//
// Future<void> addFavoriteProduct({required String name,required String price,required String image,required String product_id}) async{
//   ProductRepository productRepository = ProductRepository();
//   await productRepository.addToFavorite(name: name, price: price, image: image, product_id: product_id).then((_){
//     Fluttertoast.showToast(msg: "added to favorite");
//   });
//
//   final docRef = FirebaseFirestore.instance.collection("favorite").doc();
//   final uid = FirebaseAuth.instance.currentUser?.uid.toString();
//
//   final product = {
//     "name":name,
//     "image_url":image,
//     "price":price,
//     "u_id": uid,
//     "product_id": product_id,
//     "doc_id": docRef.id,
//   };
//
//   state.whenData((products) {
//     state = AsyncData([...products,product]);
//   });
// }
//
// Future<void> removeProduct({required String docId}) async{
//   log("remove product called");
//   ProductRepository productRepository = ProductRepository();
//   await productRepository.removeFromFavorite(docId: docId).then((_){
//     Fluttertoast.showToast(msg: "remove product from favorite");
//   });
//   state.whenData((products) {
//     state = AsyncData(products.where((element)=> element["doc_id"] != docId).toList());
//   });
// }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SellerProductRepository {
  final fireBaseFireStore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid.toString();

  ///   <--------- Products --------->   ///

  Future<void> addProduct({required String name, required String price,required int quantity, required File? image}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("product_images").child("images/${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(image!);
    await uploadTask.whenComplete(() => debugPrint("Image uploaded to Firebase Storage"));
    String imageURL = await ref.getDownloadURL();

    final docRef = fireBaseFireStore.collection("product").doc();

    final data = {"name": name, "image_url": imageURL, "price": price,"quantity":quantity,"u_id": uid, "id": docRef.id,"sell_product":0};
    // await fireBaseFireStore.collection("product").add(data);
    await docRef.set(data);
  }

  Future<List<Map<String, dynamic>>> allProducts() async {
    final favProduct = await fireBaseFireStore.collection("product").where("u_id", isEqualTo: uid).get();
    return favProduct.docs.map((element) => element.data()).toList();
  }

  Future<void> updateProduct({required Map<String,dynamic> data,File? imageFile,String? imageUrl}) async {
    if(imageFile != null){
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("product_images").child("images/${DateTime.now()}");
      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() => debugPrint("Image uploaded to Firebase Storage"));
      imageUrl = await ref.getDownloadURL();
    }

    final docId = data["id"].toString();
    await fireBaseFireStore.collection("product").doc(docId).update({...data,"image_url":imageUrl});
  }

  Future<void> deleteProduct({required String docId}) async {
    await fireBaseFireStore.collection("product").doc(docId).delete();
  }

  Future<void> updateProductQuantity({required List<Map<String, dynamic>> data}) async {

    final batch = fireBaseFireStore.batch();
    final docRef = fireBaseFireStore.collection("product");

    data.forEach((product) {
      batch.update(docRef.doc(product["id"].toString()), product);
    });
    batch.commit();
  }

}

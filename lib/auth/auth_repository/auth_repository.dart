import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRepository{

  final auth = FirebaseAuth.instance;
  final fireBaseFireStore = FirebaseFirestore.instance;


  ///     <---------- Users ---------->     ///
  Future<bool> signUp({required String email,required String password,required String  userName})async{

    final  user = ValueNotifier(false);

    await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
      await value.user?.updateDisplayName(userName);
      var uid = FirebaseAuth.instance.currentUser?.uid.toString();
      await addDataToUser(email: email,userName: userName,uid: uid,isAlreadySeller: false);
      user.value = true;
      return value;
    }).catchError((e) async {
      if (e is FirebaseAuthException) {
        if (e.code == "email-already-in-use") {

           final  userId =  await fireBaseFireStore.collection("users").where("email",isEqualTo: email).get().then((value){
              return value.docs.map((e)=> e.id).toList().first;
            });
           if(userId.isEmpty){
             await  addDataToUser(email: email,userName:  userName,isAlreadySeller: true);
             Fluttertoast.showToast(msg: "User created Successfully");
             user.value = true;

           }
           else {
             Fluttertoast.showToast(msg: "This email already taken by user");
             user.value = false;
           }
        }
      } else {
        log("Other Error: $e");
      }
    });
   return user.value;
  }

  Future<void> addDataToUser({required String email, required String userName, String? uid = "", required bool isAlreadySeller}) async {
    String? sellerId;
    if(isAlreadySeller){
       sellerId =  await fireBaseFireStore.collection("sellers").where("email",isEqualTo: email).get().then((value){
        return value.docs.map((e)=> e.id).toList().first;
      });
    }

    final data = {
      "email": email,
      "user_name": userName,
      "uid": isAlreadySeller ? sellerId : uid,
    };
    await FirebaseFirestore.instance.collection("users").doc(isAlreadySeller ? sellerId : uid).set(data);
  }

  Future<UserCredential> login({required String email,required String password})async{
    final userCredential =  await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<bool> validUser({required String uid}) async{
    final validUser = await fireBaseFireStore.collection("users").get().then((value){
      final list = value.docs.map((e) => e.id).toList();
      return list.contains(uid) ? true : false;
    });
    return validUser;
  }

  ///     <---------- Sellers ---------->     ///

  Future<bool> signUpAsSeller({required String email,required String password,required String  userName,required String mobileNo})async{

    final  user = ValueNotifier(false);

    await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
      await value.user?.updateDisplayName(userName);
      var uid = FirebaseAuth.instance.currentUser?.uid.toString();
      await addDataToSeller(email: email,userName: userName,mobileNo: mobileNo,uid: uid,isAlreadyUser: false);
      user.value = true;
      return value;
    }).catchError((e) async {
      if (e is FirebaseAuthException) {
        if (e.code == "email-already-in-use") {

          final  sellerId =  await fireBaseFireStore.collection("sellers").where("email",isEqualTo: email).get().then((value){
            return value.docs.map((e)=> e.id).toList().first;
          });
          if(sellerId.isEmpty){
            await addDataToSeller( email:email, userName: userName, mobileNo: mobileNo,isAlreadyUser: true);
            Fluttertoast.showToast(msg: "User created Successfully");
            user.value = true;
          }
          else {
            Fluttertoast.showToast(msg: "This email already taken by seller");
            user.value = false;

          }
          log("E-Mail already in use.");
        }
      } else {
        log("Other Error: $e");
      }
    });
    return user.value;
  }

  Future<void> addDataToSeller({required String email, required String userName, required String mobileNo,  String? uid = "", required bool isAlreadyUser}) async {

    String? userId;
    if(isAlreadyUser){
      userId =  await fireBaseFireStore.collection("users").where("email",isEqualTo: email).get().then((value){
        return value.docs.map((e)=> e.id).toList().first;
      });
    }
    final  data = {
      "email" : email,
      "user_name" : userName,
      "mobile_no": mobileNo,
      "uid" : isAlreadyUser ? userId : uid,
    };
    FirebaseFirestore.instance.collection("sellers").doc(isAlreadyUser ? userId : uid).set(data);
  }


  Future<UserCredential> loginAsSeller({required String email,required String password})async{
    final userCredential =  await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
  Future<bool> validSeller({required String uid}) async{
    final validUser = await fireBaseFireStore.collection("sellers").get().then((value){
      final list = value.docs.map((e) => e.id).toList();
      return list.contains(uid) ? true : false;
    });
    return validUser;
  }
}
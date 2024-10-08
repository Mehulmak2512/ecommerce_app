import 'dart:developer';
import 'package:ecommerce_app/auth/auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_auth.g.dart';

@riverpod
class UserAuth extends _$UserAuth {
  @override
 Future<void> build() async {
    return;
  }

  AuthRepository authRepository = AuthRepository();

  Future<UserCredential> loginWithEmailAndPassword({required String email,required String password}) async {
    final userCredential = await authRepository.login(email: email, password: password).then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("uId", value.user?.uid.toString() ?? "");
      log("uId -- ${value.user?.uid.toString()}");
      return value;
    });
    return userCredential;
  }

  Future<bool> signUpWithEmailAndPassword({required String email,required String password,required String userName}) async {
    final  user =  await authRepository.signUp(email: email, password: password, userName: userName).then((value){
      Fluttertoast.showToast(msg: "User create successfully");
      return value;
    });
    return user;
  }

  Future<bool> validUser({required String uid}) async{
    final result = await authRepository.validUser(uid: uid).then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool("isUser",value);
      log("isUser -- $value");
      return value;
    },);
    return result;
  }
}
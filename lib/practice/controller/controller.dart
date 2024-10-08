import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/practice/model/unknown_model_entity.dart';
import 'package:ecommerce_app/practice/network/dio_client.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'controller.g.dart';

@riverpod
class UnkonwnList extends _$UnkonwnList {
  @override
  UnknownModelEntity? build() {
    return null;
  }

  Future<UnknownModelEntity?> getUnknown({int page = 1}) async{
    if(page == 1){
      state = null;
    }
    UnknownModelEntity? res;
    try{
       res = await DioClient().getUnknown({"page":page});
       if(page == 1){
         state = res;
       }else{
         res = res?.copyWith(data: [...state?.data ?? [] , ...res.data ?? []]);
       }
       state = res;
    }on DioException catch (err) {
      final errorMessage = (err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      if (page == 1) {
        state = UnknownModelEntity();
      }
      throw e.toString();
    }
    return res;
  }

}



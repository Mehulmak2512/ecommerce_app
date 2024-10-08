
import 'package:dio/dio.dart';

import '../model/unknown_model_entity.dart';

class DioClient{

  final dio= Dio();

  Future<UnknownModelEntity?> getUnknown(Map<String,dynamic> map) async {
    try{
      final response = await dio.get("https://reqres.in/api/unknown",queryParameters: map);
      if(response.statusCode == 200){
        return UnknownModelEntity.fromJson(response.data);
      }
    }on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode}');
      rethrow;
    }catch(e){
      throw e.toString();
    }
    return null;
  }

}
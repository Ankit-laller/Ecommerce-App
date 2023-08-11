import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerceapp/core/api.dart';
import 'package:ecommerceapp/data/models/user_model.dart';

class UserRepository{
  final _api = Api();
  Future<UserModel> createAccount({
    required String email,
    required String password,
    required String username
})async{
    try{
      Response response = await _api.sendRequest.post(
        "/user/create",
        data: jsonEncode({
          "email":email,
          "password":password,
          "username": username
        })
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }
      return UserModel.fromJson(apiResponse.data);
    }catch(err){
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password
  })async{
    try{
      Response response = await _api.sendRequest.post(
          "/user/signIn",
          data: jsonEncode({
            "email":email,
            "password":password
          })
      );
      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }
      return UserModel.fromJson(apiResponse.data);
    }catch(err){
      rethrow;
    }
  }

}
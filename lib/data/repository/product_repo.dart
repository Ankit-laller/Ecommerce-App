
import 'package:dio/dio.dart';
import 'package:ecommerceapp/core/api.dart';
import 'package:ecommerceapp/data/models/category/category_model.dart';
import 'package:ecommerceapp/data/models/product_model.dart';

class ProductRepository {
  final _api = Api();

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/product");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
    try {
      Response response = await _api.sendRequest.get("/product/category/$categoryId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
    }
    catch(ex) {
      rethrow;
    }
  }

}
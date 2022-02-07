
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/categories_response.dart';

abstract class CategoriesRepo {
  Future<CategoriesResponse> fetchCategories();
}

class RealCategoriesRepo implements CategoriesRepo {
  ApiProvider _apiProvider = ApiProvider();



  @override
  Future<CategoriesResponse> fetchCategories() {
    // print("HIIIIIII");
    //   print(_apiProvider.getCategories());
    return _apiProvider.getCategories();
  }
}

class FakeCategoriesRepo implements CategoriesRepo {
  @override
  Future<CategoriesResponse> fetchCategories() {
    throw UnimplementedError();
  }
}

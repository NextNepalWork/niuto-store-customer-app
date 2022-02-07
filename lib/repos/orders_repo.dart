import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/api/responses/orders_response.dart';

abstract class OrdersRepo {
  Future<OrdersResponse> fetchOrders();
}

class RealOrdersRepo implements OrdersRepo {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<OrdersResponse> fetchOrders() async {
    return _apiProvider.getOrders();
  }
}

class FakeOrderRepo implements OrdersRepo {
  @override
  Future<OrdersResponse> fetchOrders() {
    throw UnimplementedError();
  }
}

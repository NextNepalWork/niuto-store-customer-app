import 'package:flutter_kundol/index/index.dart';

import 'package:flutter_kundol/models/orders_data.dart';
part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepo ordersRepo;

  OrdersBloc(this.ordersRepo) : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(OrdersEvent event) async* {
    if (event is GetOrders && AppData.user != null) {
      try {
        final ordersResponse = await ordersRepo.fetchOrders();

        if (ordersResponse.status == AppConstants.STATUS_SUCCESS &&
            ordersResponse.data != null)
          yield OrdersLoaded(ordersResponse.data);
        else
          yield OrdersError(ordersResponse.message);
      } on Error {
        yield OrdersError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

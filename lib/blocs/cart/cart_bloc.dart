import 'package:flutter_kundol/index/index.dart';
part 'cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo;

  CartBloc(this.cartRepo) : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is GetCart) {
      try {
        final cartResponse = await cartRepo.getCart();
        if (cartResponse.status == AppConstants.STATUS_SUCCESS &&
            cartResponse.data != null)
          yield CartLoaded(cartResponse.data);
        else
          yield CartError(cartResponse.message);
      } on Error {
        yield CartError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is DeleteCartItem) {
      try {
        final deleteCartResponse =
            await cartRepo.deleteCartItem(event.productId, event.combinationId);
        if (deleteCartResponse.status == AppConstants.STATUS_SUCCESS) {
          yield CartDeleted(event.productId);
        } else
          yield CartError(deleteCartResponse.message);
      } on Error {
        yield CartError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is ApplyCoupon) {
      try {
        final applyCouponResponse = await cartRepo.applyCoupon(event.coupon);
        if (applyCouponResponse.status == AppConstants.STATUS_SUCCESS) {
          yield CouponApplied(applyCouponResponse.data);
        } else
          yield CartCouponError(applyCouponResponse.message);
      } on Error {
        yield CartCouponError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

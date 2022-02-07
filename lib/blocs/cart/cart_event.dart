part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent {
  const GetCart();

  @override
  List<Object> get props => [];
}

class DeleteCartItem extends CartEvent {
  final int productId;
  final String combinationId;

  const DeleteCartItem(this.productId, this.combinationId);

  @override
  List<Object> get props => [this.productId, this.combinationId];
}

class ApplyCoupon extends CartEvent {
  final String coupon;

  ApplyCoupon(this.coupon);

  @override
  List<Object> get props => [this.coupon];
}

part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();

  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<CartData> cartData;

  const CartLoaded(this.cartData);

  @override
  List<Object> get props => [this.cartData];
}

class CartError extends CartState {
  final String error;

  const CartError(this.error);

  @override
  List<Object> get props => [this.error];
}

class CartCouponError extends CartState {
  final String error;

  const CartCouponError(this.error);

  @override
  List<Object> get props => [this.error];
}

class CartDeleted extends CartState {
  final int cartItemId;

  const CartDeleted(this.cartItemId);

  @override
  List<Object> get props => [this.cartItemId];
}

class CouponApplied extends CartState {
  final CouponData couponData;

  const CouponApplied(this.couponData);

  @override
  List<Object> get props => [this.couponData];
}

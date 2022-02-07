
part of 'top_selling_products_bloc.dart';

enum TopSellingProductsStatus { initial, success, failure }

class TopSellingProductsState extends Equatable {
  final List<Product> products;
  final TopSellingProductsStatus status;
  final bool hasReachedMax;
  final pageNo;

  const TopSellingProductsState({this.products, this.status, this.hasReachedMax, this.pageNo});

  TopSellingProductsState copyWith(
      {TopSellingProductsStatus status,
        List<Product> products,
        bool hasReachedMax,
        int pageNo,}) {
    return TopSellingProductsState(products: products ?? this.products, status: status ?? this.status,hasReachedMax: hasReachedMax?? this.hasReachedMax, pageNo: pageNo?? this.pageNo);
  }

  @override
  List<Object> get props =>
      [this.products, this.status, this.hasReachedMax, this.pageNo];
}

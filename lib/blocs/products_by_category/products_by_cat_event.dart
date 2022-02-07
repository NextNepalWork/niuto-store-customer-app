
part of 'products_by_cat_bloc.dart';

abstract class ProductsByCatEvent extends Equatable {
  const ProductsByCatEvent();
}

class GetProductsByCat extends ProductsByCatEvent {
  final int categoryId;
  final String sortBy;
  const GetProductsByCat(this.categoryId, this.sortBy);

  @override
  List<Object> get props => [this.categoryId, this.sortBy];
}

class CategoryChanged extends ProductsByCatEvent {
  final int categoryId;
  CategoryChanged(this.categoryId);

  @override
  List<Object> get props => [this.categoryId];
}

class SortByChanged extends ProductsByCatEvent {

  final String sortBy;
  SortByChanged(this.sortBy);

  @override
  List<Object> get props => [this.sortBy];
}

class SortTypeChanged extends ProductsByCatEvent {

  final String sortType;
  SortTypeChanged(this.sortType);

  @override
  List<Object> get props => [this.sortType];
}
class FiltersChanged extends ProductsByCatEvent {

  final String filters;

  FiltersChanged(this.filters);

  @override
  List<Object> get props => [this.filters];
}

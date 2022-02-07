import 'package:flutter_kundol/index/index.dart';
import 'package:flutter_kundol/models/products/product.dart';
part 'detail_screen_event.dart';

part 'detail_screen_state.dart';

class DetailScreenBloc extends Bloc<DetailPageEvent, DetailPageState> {
  final CartRepo cartRepo;
  final ProductsRepo productsRepo;

  DetailScreenBloc(this.cartRepo, this.productsRepo)
      : super(DetailPageInitial());

  @override
  Stream<DetailPageState> mapEventToState(DetailPageEvent event) async* {
    if (event is GetQuantity) {
      try {
        final response = await cartRepo.checkQuantity(
            event.productId, event.productType, event.combinationId);
        if (response.status == AppConstants.STATUS_SUCCESS &&
            response.data != null) {
          yield GetQuantityLoaded(response.data);
        } else {
          yield DetailPageError(response.message);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is AddToCart) {
      try {
        final response = await cartRepo.addToCart(
            event.productId, event.qty, event.combinationId);
        if (response.status == AppConstants.STATUS_SUCCESS) {
          yield ItemCartAdded(response.message, response.data.session);
        } else {
          yield DetailPageError(response.message);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    } else if (event is GetProductById) {
      try {
        final response = await productsRepo.fetchProductById(event.productId);
        if (response.status == AppConstants.STATUS_SUCCESS &&
            response.data != null) {
          yield ProductDetailsLoaded(response.data);
        } else {
          yield DetailPageError(response.message);
        }
      } on Error {
        yield DetailPageError("Some Error Occurred");
      }
    }
  }
}

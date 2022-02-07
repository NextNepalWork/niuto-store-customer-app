import 'package:flutter_kundol/index/index.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepo categoriesRepo;

  CategoriesBloc(this.categoriesRepo) : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is GetCategories) {
      try {
        final categoriesResponse = await categoriesRepo.fetchCategories();

        if (categoriesResponse.status == AppConstants.STATUS_SUCCESS &&
            categoriesResponse.data != null)
          yield CategoriesLoaded(categoriesResponse);
        else
          yield CategoriesError(categoriesResponse.message);
      } on Error {
        yield CategoriesError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

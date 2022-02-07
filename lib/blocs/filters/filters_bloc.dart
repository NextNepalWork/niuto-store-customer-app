import 'package:flutter_kundol/index/index.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final FiltersRepo filtersRepo;

  FiltersBloc(this.filtersRepo) : super(FiltersInitial());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is GetFilters) {
      try {
        final filtersResponse = await filtersRepo.getFilters();
        if (filtersResponse.status == AppConstants.STATUS_SUCCESS &&
            filtersResponse.data != null)
          yield FiltersLoaded(filtersResponse);
        else
          yield FiltersError(filtersResponse.message);
      } on Error {
        yield FiltersError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

import 'package:flutter_kundol/index/index.dart';

part 'countries_event.dart';

part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final CountriesRepo countriesRepo;

  CountriesBloc(this.countriesRepo) : super(CountriesInitial());

  @override
  Stream<CountriesState> mapEventToState(
    CountriesEvent event,
  ) async* {
    if (event is GetCountries) {
      try {
        yield CountriesLoading();
        final bannersResponse = await countriesRepo.fetchCountries();
        if (bannersResponse.status == AppConstants.STATUS_SUCCESS &&
            bannersResponse.data != null)
          yield CountriesLoaded(bannersResponse);
        else
          yield CountriesError(bannersResponse.message);
      } on Error {
        yield CountriesError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

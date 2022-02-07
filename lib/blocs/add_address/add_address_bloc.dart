import 'package:flutter_kundol/index/index.dart';
part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddressRepo addressRepo;

  AddAddressBloc(this.addressRepo) : super(AddAddressInitial());

  @override
  Stream<AddAddressState> mapEventToState(AddAddressEvent event) async* {
    if (event is AddAddress) {
      if (AppData.user == null) {
        yield AddAddressLoaded(null);
        return;
      }
      try {
        final addressResponse = await addressRepo.addAddress(
            event.firstName,
            event.lastName,
            event.gender,
            event.company,
            event.streetAddress,
            event.suburb,
            event.postCode,
            event.dob,
            event.city,
            event.countryId,
            event.state_id,
            event.lat,
            event.lng,
            event.phone);
        if (addressResponse.status == AppConstants.STATUS_SUCCESS)
          yield AddAddressLoaded(addressResponse);
        else
          yield AddAddressError(addressResponse.message);
      } on Error {
        yield AddAddressError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

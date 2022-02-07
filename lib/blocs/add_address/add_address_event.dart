part of 'add_address_bloc.dart';

abstract class AddAddressEvent extends Equatable {
  const AddAddressEvent();
}

class AddAddress extends AddAddressEvent {
  final String firstName;
  final String lastName;
  final String gender;
  final String company;
  final String streetAddress;
  final String suburb;
  final String postCode;
  final String dob;
  final String city;
  final int countryId;
  final int state_id;
  final String lat;
  final String lng;
  final String phone;


  AddAddress(
      this.firstName,
      this.lastName,
      this.gender,
      this.company,
      this.streetAddress,
      this.suburb,
      this.postCode,
      this.dob,
      this.city,
      this.countryId,
      this.state_id,
      this.lat,
      this.lng,
      this.phone);

  @override
  List<Object> get props => [
    this.firstName,
    this.lastName,
    this.gender,
    this.company,
    this.streetAddress,
    this.suburb,
    this.postCode,
    this.dob,
    this.city,
    this.countryId,
    this.state_id,
    this.lat,
    this.lng,
    this.phone
  ];
}

part of 'add_addressbook_bloc.dart';

abstract class AddAddressBookEvent extends Equatable {
  const AddAddressBookEvent();
}

class AddAddressBook extends AddAddressBookEvent {
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


  AddAddressBook(
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

class UpdateAddressBook extends AddAddressBookEvent {
  final int id;
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


  UpdateAddressBook(
      this.id,
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
    this.id,
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

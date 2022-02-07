import 'package:flutter_kundol/index/index.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo profileRepo;

  ProfileBloc(this.profileRepo) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateProfile) {
      try {
        yield ProfileLoading();
        final updateProfileResponse = await profileRepo.updateProfile(
            event.firstName,
            event.lastName,
            event.password,
            event.confirmPassword);
        if (updateProfileResponse.status == AppConstants.STATUS_SUCCESS &&
            updateProfileResponse.data != null)
          yield ProfileUpdated(updateProfileResponse);
        else
          yield ProfileError(updateProfileResponse.message);
      } on Error {
        yield ProfileError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

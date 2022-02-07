import 'package:flutter_kundol/index/index.dart';

part 'banners_event.dart';

part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  final BannersRepo bannersRepo;

  BannersBloc(this.bannersRepo) : super(BannersInitial());

  @override
  Stream<BannersState> mapEventToState(
    BannersEvent event,
  ) async* {
    if (event is GetBanners) {
      try {
        final bannersResponse = await bannersRepo.fetchBanners();
        if (bannersResponse.status == AppConstants.STATUS_SUCCESS &&
            bannersResponse.data != null)
          yield BannersLoaded(bannersResponse);
        else
          yield BannersError(bannersResponse.message);
      } on Error {
        yield BannersError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

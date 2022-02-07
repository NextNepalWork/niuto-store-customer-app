import 'package:flutter_kundol/index/index.dart';

part 'reward_event.dart';
part 'reward_state.dart';

class RewardBloc extends Bloc<RewardEvent, RewardState> {
  final RewardRepo rewardRepo;

  RewardBloc(this.rewardRepo) : super(RewardInitial());

  @override
  Stream<RewardState> mapEventToState(RewardEvent event) async* {
    var rewardResponse;
    if (event is GetRewardPoints) {
      try {
        rewardResponse = await rewardRepo.getRewardPoints();
        if (rewardResponse.status == AppConstants.STATUS_SUCCESS &&
            rewardResponse.data != null)
          yield RewardLoaded(rewardResponse);
        else
          yield RewardError(rewardResponse.message);
      } on Error {
        yield RewardError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is RedeemPoints) {
      try {
        final redeemResponse = await rewardRepo.redeemRewardPoints();
        if (redeemResponse.status == AppConstants.STATUS_SUCCESS)
          yield RedeemLoaded(redeemResponse, rewardResponse);
        else
          yield RewardError(redeemResponse.message);
      } on Error {
        yield RewardError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

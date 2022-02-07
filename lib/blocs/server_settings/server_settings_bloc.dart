import 'dart:async';

import 'package:flutter_kundol/index/index.dart';
part 'server_settings_event.dart';
part 'server_settings_state.dart';

class ServerSettingsBloc
    extends Bloc<ServerSettingsEvent, ServerSettingsState> {
  final ServerSettingsRepo serverSettingsRepo;

  ServerSettingsBloc(this.serverSettingsRepo) : super(ServerSettingsInitial());

  @override
  Stream<ServerSettingsState> mapEventToState(
    ServerSettingsEvent event,
  ) async* {
    if (event is GetServerSettings) {
      try {
        final settingsResponse = await serverSettingsRepo.fetchServerSettings();
        if (settingsResponse.status == AppConstants.STATUS_SUCCESS &&
            settingsResponse.data != null)
          yield ServerSettingsLoaded(settingsResponse);
        else
          yield ServerSettingsError(settingsResponse.message);
      } on Error catch (error) {
        print(error.stackTrace);
        yield ServerSettingsError("Something went wrong!");
      }
    }
  }
}

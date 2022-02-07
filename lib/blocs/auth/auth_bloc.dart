import 'package:flutter_kundol/index/index.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is PerformLogin) {
      try {
        final loginResponse =
            await authRepo.loginUser(event.email, event.password);
        if (loginResponse.status == AppConstants.STATUS_SUCCESS &&
            loginResponse.data != null)
          yield Authenticated(loginResponse.data);
        else
          yield AuthFailed(loginResponse.message);
      } on Error {
        yield AuthFailed("Some Error");
      }
    } else if (event is PerformRegister) {
      try {
        final registerResponse = await authRepo.registerUser(event.firstName,
            event.lastName, event.email, event.password, event.confirmPassword);
        if (registerResponse.status == AppConstants.STATUS_SUCCESS &&
            registerResponse.data != null)
          yield Authenticated(registerResponse.data);
        else
          yield AuthFailed(registerResponse.message);
      } on Error {
        yield AuthFailed("Some error");
      }
    } else if (event is PerformLogout) {
      try {
        final logoutResponse = await authRepo.logoutUser();
        if (logoutResponse.status == AppConstants.STATUS_SUCCESS) {
          AppData.user = null;
          final sharedPrefService = await SharedPreferencesService.instance;
          sharedPrefService.logoutUser();
          yield UnAuthenticated();
        } else
          yield AuthFailed(logoutResponse.message);
      } on Error {
        yield AuthFailed("Some error");
      }
    } else if (event is PerformAutoLogin) {
      yield Authenticated(event.user);
    } else if (event is PerformForgotPassword) {
      try {
        final forgotPasswordResponse =
            await authRepo.forgotPassword(event.email);
        if (forgotPasswordResponse.status == AppConstants.STATUS_SUCCESS) {
          yield EmailSent(forgotPasswordResponse.message);
        } else
          yield AuthFailed(forgotPasswordResponse.message);
      } on Error {
        yield AuthFailed("Some error");
      }
    }
  }
}

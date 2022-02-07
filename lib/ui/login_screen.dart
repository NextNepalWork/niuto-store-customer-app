import 'dart:ui';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:flutter_kundol/ui/forgot_screen.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _signInEmailController = new TextEditingController();
    TextEditingController _signInPasswordController =
        new TextEditingController();
    TextEditingController _signUpFirstNameController =
        new TextEditingController();
    TextEditingController _signUpLastNameController =
        new TextEditingController();
    TextEditingController _signUpEmailController = new TextEditingController();
    TextEditingController _signUpPasswordController =
        new TextEditingController();
    TextEditingController _signUpConfirmPasswordController =
        new TextEditingController();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) => DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                iconTheme: Theme.of(context).iconTheme,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Image.asset("assets/icons/logo.png")),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(TabBar(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: ShapeDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  labelStyle: TextStyle(),
                  unselectedLabelColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      text: "Login",
                    ),
                    Tab(
                      text: "Register",
                    ),
                  ],
                )),
                pinned: true,
              ),
            ],
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            controller: _signInEmailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your email",
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            obscureText: true,
                            autofocus: false,
                            controller: _signInPasswordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your password",
                                focusedBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 0.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotScreen(),
                                      ));
                                },
                                child: Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          height: 50.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                    PerformLogin(_signInEmailController.text,
                                        _signInPasswordController.text));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                width: 50.0,
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Or sign in with",
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppStyles.COLOR_GREY_DARK
                                      : AppStyles.COLOR_GREY_LIGHT,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppStyles.COLOR_GREY_DARK
                                    : AppStyles.COLOR_GREY_LIGHT,
                                width: 50.0,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInFB();
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/facebook.png",
                                    height: 55,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                //doGoogleLogin();
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/google.png",
                                    height: 50,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppStyles.COLOR_GREY_DARK
                                          : AppStyles.COLOR_GREY_LIGHT,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _signUpFirstNameController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "First Name",
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _signUpLastNameController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Last Name",
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _signUpEmailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _signUpPasswordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppStyles.COLOR_LITE_GREY_DARK
                                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: TextField(
                            autofocus: false,
                            controller: _signUpConfirmPasswordController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppStyles.COLOR_GREY_DARK
                                        : AppStyles.COLOR_GREY_LIGHT,
                                    fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          height: 50.0,
                          width: double.maxFinite,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                    PerformRegister(
                                        _signUpFirstNameController.text,
                                        _signUpLastNameController.text,
                                        _signUpEmailController.text,
                                        _signUpPasswordController.text,
                                        _signUpConfirmPasswordController.text));
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context, state) async {
          if (state is Authenticated) {
            AppData.user = state.user;
            AppData.accessToken = state.user.token;
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome " + state.user.firstName)));

            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserID(state.user.id);
            await sharedPrefService.setUserFirstName(state.user.firstName);
            await sharedPrefService.setUserLastName(state.user.lastName);
            await sharedPrefService.setUserEmail(state.user.email);
            await sharedPrefService.setUserToken(state.user.token);

            Navigator.pop(context);
          } else if (state is UnAuthenticated) {
            AppData.user = null;
            AppData.accessToken = null;
            Navigator.pop(context);
          } else if (state is EmailSent) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }

/*
  void doGoogleLogin() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      signInWithGoogle(_googleSignIn, _auth);
    } on Exception catch (error) {
      print(error);
    }
  }

  Future<UserCredential> signInWithGoogle(
      GoogleSignIn _googleSignIn, FirebaseAuth _auth) async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult = await _auth.signInWithCredential(credential);

    var _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = _auth.currentUser;
    assert(_user.uid == currentUser.uid);
    //model.state =ViewState.Idle;
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
*/

  void signInFB() async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        final email = await fb.getUserEmail();
        if (email != null) print('And your email is $email');

        //loginBloc.add(ProcessLoginWithFacebook(accessToken.token));

        print("ACCESS TOKEN = " + accessToken.token);

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 35.0;

  @override
  double get maxExtent => 35.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

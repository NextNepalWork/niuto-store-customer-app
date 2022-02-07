import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_kundol/blocs/profile/update_profile_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';

import 'package:flutter_kundol/tweaks/shared_pref_service.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstNameController.text = AppData.user.firstName;
    _lastNameController.text = AppData.user.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppStyles.COLOR_LITE_GREY_DARK
                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                autofocus: false,
                controller: _firstNameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "First Name",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: Icon(
                      Icons.person_outline,
                    )),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppStyles.COLOR_LITE_GREY_DARK
                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                autofocus: false,
                controller: _lastNameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Last Name",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: Icon(
                      Icons.person_outline,
                    )),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppStyles.COLOR_LITE_GREY_DARK
                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                autofocus: false,
                controller: _passwordController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    )),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppStyles.COLOR_LITE_GREY_DARK
                    : AppStyles.COLOR_LITE_GREY_LIGHT,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                autofocus: false,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
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
            BlocConsumer<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                    height: 40.0,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_firstNameController.text.isNotEmpty &&
                              _lastNameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty)
                            BlocProvider.of<ProfileBloc>(context).add(
                                UpdateProfile(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _passwordController.text,
                                    _confirmPasswordController.text));
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        )),
                  );
                }
              },
              listener: (context, state) async {
                if (state is ProfileUpdated) {
                  setState(() {
                    AppData.user.firstName =
                        state.updateProfileResponse.data.customerFirstName;
                    AppData.user.lastName =
                        state.updateProfileResponse.data.customerLastName;
                  });

                  final sharedPrefService =
                      await SharedPreferencesService.instance;
                  await sharedPrefService.setUserFirstName(
                      state.updateProfileResponse.data.customerFirstName);
                  await sharedPrefService.setUserLastName(
                      state.updateProfileResponse.data.customerLastName);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.updateProfileResponse.message)));
                } else if (state is ProfileError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

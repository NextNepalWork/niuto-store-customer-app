import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/address/address_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/address_repo.dart';
import 'package:flutter_kundol/ui/shipping_screen.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController _signInEmailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Forgot Password",
              style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
              horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
          child: Column(
            children: [
              TextField(
                autofocus: false,
                controller: _signInEmailController,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppStyles.COLOR_LITE_GREY_DARK
                        : AppStyles.COLOR_LITE_GREY_LIGHT,
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Enter your email",
                    hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_GREY_LIGHT,
                        fontSize: 14),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 40.0,
                width: double.maxFinite,
                child: ElevatedButton(
                    onPressed: () {
                      if (_signInEmailController.text.isNotEmpty)
                        BlocProvider.of<AuthBloc>(context).add(
                            PerformForgotPassword(
                                _signInEmailController.text.trim()));
                    },
                    child: Text("Send")),
              ),
            ],
          ),
        ));
  }
}

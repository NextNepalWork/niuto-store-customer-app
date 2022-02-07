import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/contact_us/contact_us_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController _messageController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

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
          title:
              Text("Contact Us", style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
              horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
          child: BlocConsumer<ContactUsBloc, ContactUsState>(
            builder: (BuildContext context, state) {
              return Column(
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
                      controller: _emailController,
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
                      minLines: 5,
                      maxLines: null,
                      controller: _messageController,
                      keyboardType: TextInputType.multiline,
                      autofocus: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "  Your comment",
                          hintStyle: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                              fontSize: 14)),
                    ),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    height: 40.0,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ContactUsBloc>(context).add(
                              SubmitContactUs(
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _emailController.text,
                                  _messageController.text));
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              );
            },
            listener: (BuildContext context, state) {
              if (state is ContactUsLoaded) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is ContactUsError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
        ));
  }
}

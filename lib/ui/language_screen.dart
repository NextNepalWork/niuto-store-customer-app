import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/get_languages/get_language_bloc.dart';
import 'package:flutter_kundol/blocs/language/language_bloc.dart';
import 'package:flutter_kundol/blocs/page/page_bloc.dart';
import 'package:flutter_kundol/blocs/theme/theme_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/repos/pages_repo.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:flutter_kundol/ui/content_screen.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share/share.dart';

import '../main.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  GetLanguageBloc languageBloc;

  @override
  void initState() {
    super.initState();
    languageBloc = BlocProvider.of<GetLanguageBloc>(context);
    languageBloc.add(GetLanguages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Languages"),
      ),
      body: BlocBuilder(
        bloc: languageBloc,
        builder: (BuildContext context, state1) {
          if (state1 is GetLanguageLoaded)
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      BlocProvider.of<LanguageBloc>(context).add(
                          LanguageSelected(state1
                              .languageResponse.data[index]));
                      RestartWidget.restartApp(context);
                    },
                    title:
                        Text(state1.languageResponse.data[index].languageName),
                    subtitle: Text(state1.languageResponse.data[index].code),
                    trailing: Icon((state1.languageResponse.data[index].code.toLowerCase().trim() == state.languageData.code)
                        ? Icons.radio_button_on
                        : Icons.radio_button_off),
                  );
                },
                itemCount: state1.languageResponse.data.length,
              ),
            );
          else if (state1 is GetLanguageError)
            return Text(state1.error);
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}

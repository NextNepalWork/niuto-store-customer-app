import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/currency/currency_bloc.dart';
import 'package:flutter_kundol/blocs/get_currencies/get_currency_bloc.dart';
import 'package:flutter_kundol/blocs/get_languages/get_language_bloc.dart';
import 'package:flutter_kundol/main.dart';

class CurrenciesScreen extends StatefulWidget {
  @override
  _CurrenciesScreenState createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  GetCurrenciesBloc currencyBloc;

  @override
  void initState() {
    super.initState();
    currencyBloc = BlocProvider.of<GetCurrenciesBloc>(context);
    currencyBloc.add(GetCurrencies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currencies"),
      ),
      body: BlocBuilder(
        bloc: currencyBloc,
        builder: (BuildContext context, state1) {
          if (state1 is GetCurrencyLoaded)
            return BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      BlocProvider.of<CurrencyBloc>(context).add(
                          CurrencySelected(
                              state1.currenciesResponse.data[index]));
                      RestartWidget.restartApp(context);
                    },
                    title: Text(state1.currenciesResponse.data[index].title),
                    subtitle: Text(state1.currenciesResponse.data[index].code),
                    trailing: Icon(
                        (state1.currenciesResponse.data[index].currencyId ==
                                state.currency.currencyId)
                            ? Icons.radio_button_on
                            : Icons.radio_button_off),
                  );
                },
                itemCount: state1.currenciesResponse.data.length,
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

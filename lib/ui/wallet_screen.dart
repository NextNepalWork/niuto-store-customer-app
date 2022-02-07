import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen();

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Wallet", style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Current Credit"),
              Text(
                "\$0.00",
                style: TextStyle(color: Colors.black, fontSize: 21),
              )
            ],
          ),
        ));
  }
}

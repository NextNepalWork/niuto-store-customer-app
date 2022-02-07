import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/cart/cart_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/ui/widgets/app_bar.dart';

class AddShippingScreen extends StatefulWidget {
  @override
  _AddShippingState createState() => _AddShippingState();
}

class _AddShippingState extends State<AddShippingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Add Address", style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: Center(child: Text("Add Address"),)
    );
  }
}

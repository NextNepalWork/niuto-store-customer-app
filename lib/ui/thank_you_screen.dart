import 'package:flutter/material.dart';
import 'package:flutter_kundol/index/index.dart';

class ThankYouScreen extends StatefulWidget {
  ThankYouScreen();

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Checkout", style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              height: 180,
              width: double.infinity,
              child: Column(
                
                children: [
                  
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/icons/logo.png"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Thank You & Visit Again !!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Order Status',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                            TextButton(
                          onPressed: () {},
                          child: Text(
                            '',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Center(child: Text("Thank You")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BlocProvider(
                          create: (BuildContext context) {
                            return OrdersBloc(RealOrdersRepo())
                              ..add(GetOrders());
                          },
                          child: OrdersScreen()),
                    ),
                    (route) => route.isFirst,
                  );
                },
                child: Text("Order Status")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text("Continue Shopping")),
          ],
        ),
      ),
    );
  }
}

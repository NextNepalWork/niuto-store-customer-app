import 'package:flutter_kundol/blocs/checkout/checkout_bloc.dart';
import 'package:flutter_kundol/index/index.dart';

class PaymentScreen extends StatefulWidget {
  final List<CartData> cartItems;
  final CouponData couponData;
  final AddressData addressData;

  PaymentScreen(this.cartItems, this.couponData, this.addressData);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Payment", style: Theme.of(context).textTheme.headline6),
          elevation: 4.0,
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 65,
                  width: 190,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (BuildContext context) {
                                    return CheckoutBloc(RealCheckoutRepo());
                                  },
                                  child: CheckoutScreen(
                                    widget.cartItems,
                                    widget.couponData,
                                    widget.addressData,
                                    "cod",
                                    "Cash On Delivery",
                                  ))),
                        );
                      },
                      enabled: true,
                      leading: Image.asset(
                        "assets/icons/cash.png",
                        filterQuality: FilterQuality.high,
                        height: 30,
                        //color: Colors.green,
                      ),
                      title: Text("Cash On Delivery"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                  width: 190,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (BuildContext context) {
                                    return CheckoutBloc(RealCheckoutRepo());
                                  },
                                  child: CheckoutScreen(
                                      widget.cartItems,
                                      widget.couponData,
                                      widget.addressData,
                                      "stripe",
                                      "Card Payment"))), // stripe, paypal
                        );
                      },
                      enabled: true,
                      leading: Image.asset(
                        "assets/icons/card.png",
                        filterQuality: FilterQuality.high,
                        height: 30,
                        //color: Colors.green,
                      ),
                      title: Text("Card Payment"),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 65,
                  width: 190,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (BuildContext context) {
                                    return CheckoutBloc(RealCheckoutRepo());
                                  },
                                  child: CheckoutScreen(
                                      widget.cartItems,
                                      widget.couponData,
                                      widget.addressData,
                                      "banktransfer",
                                      "Bank Transfer"))),
                        );
                      },
                      enabled: true,
                      leading: Image.asset(
                        "assets/icons/bank.png",
                        filterQuality: FilterQuality.high,
                        height: 30,
                        //color: Colors.green,
                      ),
                      title: Text("Bank Transfer"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                  width: 190,
                ),
              ],
            ),
          ],
        ));
  }
}

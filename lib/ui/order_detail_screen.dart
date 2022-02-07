import 'package:flutter_kundol/index/index.dart';
import 'package:flutter_kundol/models/orders_data.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrdersData ordersData;

  OrderDetailScreen(this.ordersData);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double shipping = 0;
    double tax = 0;
    double orderTotal = 0;

    for (int i = 0; i < widget.ordersData.orderDetail.length; i++) {
      subtotal += double.parse(
          widget.ordersData.orderDetail[i].product.productPrice.toString());
      shipping = 0;
      tax = 0;
      orderTotal = subtotal;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:
            Text("Order Detail", style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 15, right: 15),
              itemCount: widget.ordersData.orderDetail.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          child: CachedNetworkImage(
                            imageUrl: ApiProvider.imgMediumUrlString +
                                widget.ordersData.orderDetail[index].product
                                    .productGallary.gallaryName,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // widget.ordersData.orderDetail[index].productPrice,
                                // //AppData.currency.code +
                                double.tryParse(widget.ordersData
                                        .orderDetail[index].product.productPrice
                                        .toString())
                                    .toStringAsFixed(2),
                                style: TextStyle(fontSize: 12),
                              ),
                              Container(
                                width: 218,
                                child: Text(
                                  widget.ordersData.orderDetail[index].product
                                      .productSlug,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Text(
                                "1, Black, Large",
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                "Qty: " +
                                    widget.ordersData.orderDetail[index]
                                        .productQty
                                        .toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 15);
              },
            ),
            Divider(
              thickness: 4,
              color: Color(0xFFE6E8E9),
            ),
            ListTile(
              onLongPress: () {},
              enabled: true,
              isThreeLine: true,
              tileColor: Colors.white,
              leading: Icon(Icons.location_pin),
              title: Text(widget.ordersData.deliveryFirstName +
                  " " +
                  widget.ordersData.billingLastName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.ordersData.deliveryStreetAadress),
                  Text(widget.ordersData.deliveryPhone),
                ],
              ),
            ),
            Divider(
              thickness: 4,
              color: Color(0xFFE6E8E9),
            ),
            ListTile(
              onLongPress: () {},
              enabled: true,
              isThreeLine: true,
              tileColor: Colors.white,
              leading: Icon(Icons.account_balance_wallet),
              title: Text(widget.ordersData.deliveryFirstName +
                  " " +
                  widget.ordersData.billingLastName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.ordersData.deliveryStreetAadress),
                  Text(widget.ordersData.deliveryPhone),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal:"),
                      Text(AppData.currency.code + subtotal.toStringAsFixed(2)),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount:"),
                      Text(AppData.currency.code + "0.00"),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Estimated Shipping:"),
                      Text(AppData.currency.code + "0.00"),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax:"),
                      Text(AppData.currency.code + "0.00"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order Total:"),
                      Text(
                        AppData.currency.code + orderTotal.toStringAsFixed(2),
                        style: TextStyle(
                          color: Color(0xFFF1435A),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

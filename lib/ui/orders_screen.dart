import 'package:flutter_kundol/index/index.dart';
import 'package:flutter_kundol/models/orders_data.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrdersBloc>(context).add(GetOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: Theme.of(context).iconTheme,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text("Orders",
                      style: Theme.of(context).textTheme.headline6),
                  elevation: 0.0,
                  bottom: TabBar(
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 2.0, color: Theme.of(context).primaryColor),
                      ),
                      labelStyle: TextStyle(),
                      unselectedLabelColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_GREY_DARK
                              : AppStyles.COLOR_GREY_LIGHT,
                      labelColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(text: "In Progress"),
                        Tab(text: "Delivered"),
                        Tab(text: "Reviews"),
                      ]),
                ),
                body: TabBarView(children: [
                  buildPage(getOrdersBy(state.ordersData, "Pending")),
                  buildPage(getOrdersBy(state.ordersData, "Delivered")),
                  buildPage(getOrdersBy(state.ordersData, "Canceled")),
                ]),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildPage(List<OrdersData> ordersData) {
    print(ordersData.length);
    return ordersData.isNotEmpty
        ? ListView.builder(
            itemCount: ordersData.length,
            itemBuilder: (context, index1) {
              double subtotal = 0;
              double orderTotal = 0;

              for (int i = 0; i < ordersData[index1].orderDetail.length; i++) {
                print(ordersData[index1].orderDetail[i].product);
                subtotal += double.parse(ordersData[index1]
                    .orderDetail[i]
                    .product
                    .productPrice
                    .toString());
                orderTotal = subtotal;
              }

              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID: " +
                                  ordersData[index1].orderId.toString()),
                              Text("Placed on 22-12-20, 13:15",
                                  style: TextStyle(
                                      color: Colors.grey[350], fontSize: 10)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetailScreen(ordersData[index1]),
                                )),
                            child: Text("View Details >",
                                style: TextStyle(
                                    color: Colors.grey[350], fontSize: 10)),
                          )
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      itemCount: ordersData[index1].orderDetail.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index2) =>
                          Container(
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
                                        ordersData[index1]
                                            .orderDetail[index2]
                                            .product
                                            .productGallary
                                            .gallaryName,
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress)),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppData.currency.code +
                                            double.parse(ordersData[index1]
                                                    .orderDetail[index2]
                                                    .product
                                                    .productPrice
                                                    .toString())
                                                .toStringAsFixed(2),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Container(
                                        width: 218,
                                        child: Text(
                                          ordersData[index1]
                                              .orderDetail[index2]
                                              .product
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
                                            ordersData[index1]
                                                .orderDetail[index2]
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
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "2 Items, Total:",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[350]),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppData.currency.code + orderTotal.toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 4,
                      color: Color(0xFFE6E8E9),
                    ),
                  ],
                ),
              );
            },
          )
        : SizedBox();
  }

  List<OrdersData> getOrdersBy(List<OrdersData> ordersData, String filterBy) {
    List<OrdersData> tempOrders = [];

    for (int i = 0; i < ordersData.length; i++) {
      if (ordersData[i].orderStatus == filterBy) {
        tempOrders.add(ordersData[i]);
      }
    }
    return tempOrders;
  }
}

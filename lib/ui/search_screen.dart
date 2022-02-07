import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_kundol/index/index.dart';
import 'package:flutter_kundol/models/products/product.dart';

class SearchScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  SearchScreen(this.navigateToNext);

  @override
  _ShippingState createState() => _ShippingState();
}

class _ShippingState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyAppBar(
            centerWidget: Container(
              height: 35.0,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppStyles.COLOR_SEARCH_BAR,
                borderRadius:
                    BorderRadius.all(Radius.circular(AppStyles.CARD_RADIUS)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_outlined,
                    size: 18.0,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 12.0, bottom: 6.0),
                      height: 25,
                      child: TextField(
                        onSubmitted: (value) {
                          if (value.isNotEmpty)
                            BlocProvider.of<ProductsSearchBloc>(context)
                                .add(GetSearchProducts(value));
                        },
                        textInputAction: TextInputAction.search,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "What are you looking for?",
                          border: InputBorder.none,
                          hintStyle: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            trailingWidget: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"))),
          ),
          Expanded(
            child: BlocBuilder<ProductsSearchBloc, ProductsSearchState>(
              builder: (context, state) {
                if (state is ProductsSearchState) {
                  switch (state.status) {
                    case ProductsSearchStatus.initial:
                      return Container();
                    case ProductsSearchStatus.success:
                      if (state.products.isEmpty)
                        return Center(child: Text("Empty"));
                      else
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppStyles.GRID_SPACING,
                            mainAxisSpacing: AppStyles.GRID_SPACING,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return getDefaultCard(state.products[index], index);
                          },
                        );
                      break;
                    case ProductsSearchStatus.failure:
                      return Text("Error");
                    case ProductsSearchStatus.loading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // bool checkForWishlist(int productId) {
  //   for (int i = 0; i < AppData.wishlistData.length; i++) {
  //     if (productId == AppData.wishlistData[i].productId) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  Widget getDefaultCard(Product product, int index) {
    switch (int.parse(
        AppData.settingsResponse.getKeyValue(SettingsResponse.CARD_STYLE))) {
      case 1:
        return CardStyleNew1(
            widget.navigateToNext, product, getCardBackground(index));
      case 2:
        return CardStyle2(
            widget.navigateToNext, product, getCardBackground(index));
      case 3:
        return CardStyle3(
            widget.navigateToNext, product, getCardBackground(index));
      case 4:
        return CardStyle4(
            widget.navigateToNext, product, getCardBackground(index));
      case 5:
        return CardStyle5(
            widget.navigateToNext, product, getCardBackground(index));
      case 6:
        return CardStyle6(
            widget.navigateToNext, product, getCardBackground(index));
      case 7:
        return CardStyle7(
            widget.navigateToNext, product, getCardBackground(index));
      case 8:
        return CardStyle8(
            widget.navigateToNext, product, getCardBackground(index));
      case 9:
        return CardStyle9(
            widget.navigateToNext, product, getCardBackground(index));
      case 10:
        return CardStyle10(
            widget.navigateToNext, product, getCardBackground(index));
      case 11:
        return CardStyle11(
            widget.navigateToNext, product, getCardBackground(index));
      case 12:
        return CardStyle12(
            widget.navigateToNext, product, getCardBackground(index));
      case 13:
        return CardStyle13(
            widget.navigateToNext, product, getCardBackground(index));
      case 14:
        return CardStyle14(
            widget.navigateToNext, product, getCardBackground(index));
      case 15:
        return CardStyle15(
            widget.navigateToNext, product, getCardBackground(index));
      case 16:
        return CardStyle16(
            widget.navigateToNext, product, getCardBackground(index));
      case 17:
        return CardStyle17(
            widget.navigateToNext, product, getCardBackground(index));
      case 18:
        return CardStyle18(
            widget.navigateToNext, product, getCardBackground(index));
      case 19:
        return CardStyle19(
            widget.navigateToNext, product, getCardBackground(index));
      case 20:
        return CardStyle20(
            widget.navigateToNext, product, getCardBackground(index));
      case 21:
        return CardStyle21(
            widget.navigateToNext, product, getCardBackground(index));
      case 22:
        return CardStyle22(
            widget.navigateToNext, product, getCardBackground(index));
      case 23:
        return CardStyle23(
            widget.navigateToNext, product, getCardBackground(index));
      case 24:
        return CardStyle24(
            widget.navigateToNext, product, getCardBackground(index));
      case 25:
        return CardStyle25(
            widget.navigateToNext, product, getCardBackground(index));
      case 26:
        return CardStyle26(
            widget.navigateToNext, product, getCardBackground(index));
      case 27:
        return CardStyle27(
            widget.navigateToNext, product, getCardBackground(index));
      default:
        return CardStyleNew1(
            widget.navigateToNext, product, getCardBackground(index));
    }
  }

  int cardColorindex = 0;

  Color getCardBackground(int index) {
    Color tempColor = AppStyles.cardColors[cardColorindex];
    cardColorindex++;
    if (cardColorindex == 4) cardColorindex = 0;
    return tempColor;
  }
}

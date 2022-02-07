import 'package:flutter_kundol/index/index.dart';
import 'package:flutter_kundol/models/products/product.dart';

class CustomSearchDelegate extends SearchDelegate {
  final Function(Widget widget) navigateToNext;
  CustomSearchDelegate({
    this.navigateToNext,
  });
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      TextButton(
          onPressed: () {
            query = '';
          },
          child: Text("clear")),
      SizedBox(
        width: 10,
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty)
      BlocProvider.of<ProductsSearchBloc>(context)
          .add(GetSearchProducts(query));
    return BlocBuilder<ProductsSearchBloc, ProductsSearchState>(
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    return Column(
      children: [
        Text(""),
      ],
    );
  }

  Widget getDefaultCard(Product product, int index) {
    switch (int.parse(
        AppData.settingsResponse.getKeyValue(SettingsResponse.CARD_STYLE))) {
      case 1:
        return CardStyleNew1(navigateToNext, product, getCardBackground(index));
      case 2:
        return CardStyle2(navigateToNext, product, getCardBackground(index));
      case 3:
        return CardStyle3(navigateToNext, product, getCardBackground(index));
      case 4:
        return CardStyle4(navigateToNext, product, getCardBackground(index));
      case 5:
        return CardStyle5(navigateToNext, product, getCardBackground(index));
      case 6:
        return CardStyle6(navigateToNext, product, getCardBackground(index));
      case 7:
        return CardStyle7(navigateToNext, product, getCardBackground(index));
      case 8:
        return CardStyle8(navigateToNext, product, getCardBackground(index));
      case 9:
        return CardStyle9(navigateToNext, product, getCardBackground(index));
      case 10:
        return CardStyle10(navigateToNext, product, getCardBackground(index));
      case 11:
        return CardStyle11(navigateToNext, product, getCardBackground(index));
      case 12:
        return CardStyle12(navigateToNext, product, getCardBackground(index));
      case 13:
        return CardStyle13(navigateToNext, product, getCardBackground(index));
      case 14:
        return CardStyle14(navigateToNext, product, getCardBackground(index));
      case 15:
        return CardStyle15(navigateToNext, product, getCardBackground(index));
      case 16:
        return CardStyle16(navigateToNext, product, getCardBackground(index));
      case 17:
        return CardStyle17(navigateToNext, product, getCardBackground(index));
      case 18:
        return CardStyle18(navigateToNext, product, getCardBackground(index));
      case 19:
        return CardStyle19(navigateToNext, product, getCardBackground(index));
      case 20:
        return CardStyle20(navigateToNext, product, getCardBackground(index));
      case 21:
        return CardStyle21(navigateToNext, product, getCardBackground(index));
      case 22:
        return CardStyle22(navigateToNext, product, getCardBackground(index));
      case 23:
        return CardStyle23(navigateToNext, product, getCardBackground(index));
      case 24:
        return CardStyle24(navigateToNext, product, getCardBackground(index));
      case 25:
        return CardStyle25(navigateToNext, product, getCardBackground(index));
      case 26:
        return CardStyle26(navigateToNext, product, getCardBackground(index));
      case 27:
        return CardStyle27(navigateToNext, product, getCardBackground(index));
      default:
        return CardStyleNew1(navigateToNext, product, getCardBackground(index));
    }
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/api/api_provider.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/products_by_category/products_by_cat_bloc.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/ui/shop_screen.dart';

class CategoryWidget2 extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  const CategoryWidget2(this.navigateToNext, {Key key}) : super(key: key);

  @override
  _CategoryWidget2State createState() => _CategoryWidget2State();
}

class _CategoryWidget2State extends State<CategoryWidget2> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context).add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(("Hot Categories").toUpperCase(),
                style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w300,
                )),
          ),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.categoriesResponse.data.length > 4 ? 4 : state.categoriesResponse.data.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppStyles.GRID_SPACING,
                      childAspectRatio: 0.9,
                      mainAxisSpacing: AppStyles.GRID_SPACING),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        widget.navigateToNext(BlocProvider(
                            create: (BuildContext context) {
                              return ProductsByCatBloc(
                                  RealProductsRepo(),
                                  BlocProvider.of<CategoriesBloc>(context),
                                  state.categoriesResponse.data[index].id,
                                  "id",
                                  "ASC",
                                  "");
                            },
                            child: ShopScreen(state.categoriesResponse.data[index], widget.navigateToNext)));
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppStyles.CARD_RADIUS),
                              child: CachedNetworkImage(
                                imageUrl: ApiProvider.imgMediumUrlString +
                                    state.categoriesResponse.data[index].gallary,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress)),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          Text(
                            state.categoriesResponse.data[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is CategoriesError)
                return Text(state.error);
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ],
      ),
    );
  }
}

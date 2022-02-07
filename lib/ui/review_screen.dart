import 'detail_screen.dart';

import 'package:flutter_kundol/index/index.dart';
import 'package:flutter_kundol/ui/detail_screen.dart';

class ReviewScreen extends StatefulWidget {
  final int productId;
  ReviewScreen(this.productId);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReviewsBloc>(context).add(GetReviews(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text("Review", style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: BlocBuilder<ReviewsBloc, ReviewsState>(
          builder: (context, state) {
            if (state is ReviewsLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: (state.reviewsData.isEmpty)
                        ? Container(
                            child: Center(
                              child: Text("Empty"),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.reviewsData.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(state.reviewsData[index].customer
                                      .customerFirstName +
                                  " " +
                                  state.reviewsData[index].customer
                                      .customerLastName),
                              subtitle: Text(state.reviewsData[index].comment),
                              leading: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration:
                                    new BoxDecoration(shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                              trailing: StarRating(
                                  starCount: 5,
                                  rating: double.parse(
                                      state.reviewsData[index].rating),
                                  onRatingChanged: (rating) {}),
                            ),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                        horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
                    height: 45.0,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: () {
                          showReviewDialog();
                        },
                        child: Text(
                          "Write a Review",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void showReviewDialog() {
    Dialog ratingDialog = Dialog(
      //this right here
      child: BlocProvider(
          create: (context) => ReviewsBloc(RealReviewsRepo()),
          child: RatingDialogBody(
            context: context,
            productId: widget.productId,
          )),
    );
    showDialog(
        context: context, builder: (BuildContext context) => ratingDialog);
  }
}

class RatingDialogBody extends StatefulWidget {
  const RatingDialogBody({
    Key key,
    @required this.context,
    @required this.productId,
  }) : super(key: key);

  final BuildContext context;
  final int productId;

  @override
  _RatingDialogBodyState createState() => _RatingDialogBodyState();
}

class _RatingDialogBodyState extends State<RatingDialogBody> {
  double rating = 0.0;

  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
            horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Rating"),
                StarRating(
                    starCount: 5,
                    rating: rating,
                    onRatingChanged: (rating) {
                      setState(() {
                        this.rating = rating;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 6.0,
            ),
            TextField(
              minLines: 5,
              maxLines: null,
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              autofocus: false,
              decoration: InputDecoration(
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? AppStyles.COLOR_LITE_GREY_DARK
                      : AppStyles.COLOR_LITE_GREY_LIGHT,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Your comment",
                  hintStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_GREY_LIGHT,
                      fontSize: 14)),
            ),
            SizedBox(
              height: 6.0,
            ),
            Container(
              height: 45.0,
              width: double.maxFinite,
              child: ElevatedButton(
                  onPressed: () {
                    if (_messageController.text.isNotEmpty)
                      BlocProvider.of<ReviewsBloc>(context).add(AddReviews(
                          widget.productId, _messageController.text, rating));
                  },
                  child: Text("Add Review")),
            ),
          ],
        ),
      ),
    );
  }
}

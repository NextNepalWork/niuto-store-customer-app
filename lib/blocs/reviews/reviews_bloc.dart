import 'package:flutter_kundol/index/index.dart';
import 'package:flutter_kundol/models/reviews_data.dart';
part 'reviews_state.dart';

part 'reviews_event.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewsRepo reviewsRepo;

  ReviewsBloc(this.reviewsRepo) : super(ReviewsInitial());

  @override
  Stream<ReviewsState> mapEventToState(ReviewsEvent event) async* {
    if (event is GetReviews) {
      try {
        final reviewsResponse = await reviewsRepo.getReviews(event.productId);
        if (reviewsResponse.status == AppConstants.STATUS_SUCCESS &&
            reviewsResponse.data != null)
          yield ReviewsLoaded(reviewsResponse.data);
        else
          yield ReviewsError(reviewsResponse.message);
      } on Error {
        yield ReviewsError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is AddReviews) {
      try {
        final addReviewsResponse = await reviewsRepo.addReview(
            event.productId, event.comment, event.rating);
        if (addReviewsResponse.status == AppConstants.STATUS_SUCCESS)
          yield ReviewsAdded(addReviewsResponse.message);
        else
          yield ReviewsError(addReviewsResponse.message);
      } on Error {
        yield ReviewsError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

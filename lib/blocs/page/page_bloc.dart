import 'package:flutter_kundol/index/index.dart';

part 'page_event.dart';
part 'page_state.dart';

class GetPageBloc extends Bloc<PageEvent, PageState> {
  PageRepo pageRepo;

  GetPageBloc(this.pageRepo) : super(GetPageInitial());

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is GetPage) {
      try {
        final pageResponse = await pageRepo.getPages(event.pageNo);
        if (pageResponse.status == AppConstants.STATUS_SUCCESS &&
            pageResponse.data != null)
          yield GetPageLoaded(pageResponse);
        else
          yield GetPageError(pageResponse.message);
      } on Error {
        yield GetPageError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}

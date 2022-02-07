import 'package:dio/dio.dart';
import 'package:flutter_kundol/index/index.dart';

class ApiProvider {
  final String _baseUrl = AppConfig.ECOMMERCE_URL + "/api/client/";

  static final String imgThumbnailUrlString =
      AppConfig.ECOMMERCE_URL + "/gallary/thumbnail";
  static final String imgMediumUrlString =
      AppConfig.ECOMMERCE_URL + "/gallary/medium";
  static final String imgLargeUrlString =
      AppConfig.ECOMMERCE_URL + "/gallary/large";

  Dio _dio;

  ApiProvider() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
        validateStatus: (status) => true,
        followRedirects: false);
    _dio = Dio(options);
    _dio.options.headers.addAll({
      'clientid': AppConfig.CONSUMER_KEY,
      'clientsecret': AppConfig.CONSUMER_SECRET,
      'content-type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'authorization': AppData.accessToken == null
          ? ""
          : 'Bearer ' + AppData.accessToken.toString(),
    });
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<SettingsResponse> getSettings() async {
    try {
      Response response = await _dio.get(_baseUrl + "setting?app_setting=1");
      return SettingsResponse.fromJson(response.data);
    } catch (error) {
      return SettingsResponse.withError(_handleError(error));
    }
  }

  Future<BannersResponse> getBanners() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "banner?getBannerNavigation=1&getBannerMedia=1&limit=100&sortBy=title&sortType=DESC&currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}");
      print(response.data);
      return BannersResponse.fromJson(response.data);
    } catch (error) {
      return BannersResponse.withError(_handleError(error));
    }
  }

  Future<CategoriesResponse> getCategories() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "category?getDetail=1&page=1&limit=100&getMedia=1&language_id=${AppData.language.id}&sortBy=id&sortType=ASC&currency=${AppData.currency.currencyId}");
      return CategoriesResponse.fromJson(response.data);
    } catch (error) {
      return CategoriesResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getProducts(int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=${AppData.currency.currencyId}&stock=1&sortType=ASC&page=" +
          pageNo.toString());
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getTopSellingProducts(int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=${AppData.currency.currencyId}&stock=1&sortType=ASC&topSelling=1&page=" +
          pageNo.toString());
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getDealsProducts(int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=${AppData.currency.currencyId}&stock=1&sortType=ASC&sortBy=discount_price&page=" +
          pageNo.toString());
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getFeaturedProducts(int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=${AppData.currency.currencyId}&stock=1&sortType=ASC&isFeatured=1&page=" +
          pageNo.toString());
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<ProductDetailResponse> getProductById(int productId) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products/" +
          productId.toString() +
          "?getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=${AppData.currency.currencyId}&stock=1");
      return ProductDetailResponse.fromJson(response.data);
    } catch (error) {
      return ProductDetailResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getSearchProducts(String keyword, int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products?limit=100&getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=${AppData.currency.currencyId}&&stock=1&page=" +
          pageNo.toString() +
          "&searchParameter=" +
          keyword);
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<ProductsResponse> getProductsByCat(int pageNo, int categoryId,
      String sortBy, String sortType, String filters) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "products?limit=10&getCategory=1&getDetail=1&language_id=${AppData.language.id}&currency=${AppData.currency.currencyId}&stock=1&sortType=" +
          sortType +
          "&page=" +
          pageNo.toString() +
          "&productCategories=" +
          categoryId.toString() +
          "&sortBy=" +
          sortBy +
          "&variations=" +
          filters);
      return ProductsResponse.fromJson(response.data);
    } catch (error) {
      return ProductsResponse.withError(_handleError(error));
    }
  }

  Future<LoginResponse> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(_baseUrl + "customer_login",
          data: jsonEncode({
            "email": email,
            "password": password,
            "session_id": AppData.sessionId
          }));
      return LoginResponse.fromJson(response.data);
    } catch (error) {
      return LoginResponse.withError(_handleError(error));
    }
  }

  Future<RegisterResponse> registerUser(String firstName, String lastName,
      String email, String password, String confirmPassword) async {
    try {
      Response response = await _dio.post(_baseUrl + "customer_register",
          data: jsonEncode({
            "email": email,
            "password": password,
            "first_name": firstName,
            "last_name": lastName,
            "confirm_password": confirmPassword,
            "status": "1",
            "session_id": AppData.sessionId
          }));
      return RegisterResponse.fromJson(response.data);
    } catch (error) {
      return RegisterResponse.withError(_handleError(error));
    }
  }

  Future<LogoutResponse> doLogout() async {
    try {
      Response response = await _dio.post(_baseUrl + "customer_logout");
      return LogoutResponse.fromJson(response.data);
    } catch (error) {
      return LogoutResponse.withError(_handleError(error));
    }
  }

  Future<AddToCartResponse> addToCart(
      int productId, int qty, int combinationId) async {
    try {
      Response response = await _dio.post(_baseUrl +
          "cart" +
          ((AppData.user == null) ? "/guest/store" : "") +
          "?currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}&product_id=" +
          productId.toString() +
          "&qty=" +
          qty.toString() +
          "&product_combination_id=" +
          ((combinationId == null) ? "" : combinationId.toString()) +
          (AppData.sessionId == null
              ? ""
              : "&session_id=" + AppData.sessionId));
      print(response.data);
      return AddToCartResponse.fromJson(response.data);
    } catch (error) {
      return AddToCartResponse.withError(_handleError(error));
    }
  }

  Future<CouponResponse> applyCoupon(String coupon) async {
    try {
      Response response = await _dio.post(_baseUrl +
          "coupon?coupon_code=" +
          coupon +
          "&currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}");
      return CouponResponse.fromJson(response.data);
    } catch (error) {
      return CouponResponse.withError(_handleError(error));
    }
  }

  Future<QuantityResponse> getQuantity(
      int productId, String productType, int combinationId) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "available_qty?product_id=" +
          productId.toString() +
          "&product_type=$productType" +
          "&product_combination_id=$combinationId&currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}");
      return QuantityResponse.fromJson(response.data);
    } catch (error) {
      return QuantityResponse.withError(_handleError(error));
    }
  }

  Future<CartResponse> getCart() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "cart" +
          ((AppData.user == null)
              ? "/guest/get?session_id=" + AppData.sessionId + "&"
              : "?") +
          "currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}");
      print(response.data);
      return CartResponse.fromJson(response.data);
    } catch (error) {
      return CartResponse.withError(_handleError(error));
    }
  }

  Future<DeleteCartResponse> deleteCartItem(
      int productId, String combinationId) async {
    try {
      Response response = await _dio.delete(_baseUrl +
          "cart" +
          ((AppData.user == null)
              ? "/guest/delete?session_id=" + AppData.sessionId + "&"
              : "/delete?") +
          "product_id=" +
          productId.toString() +
          ((combinationId == null)
              ? ""
              : "&product_combination_id=" + combinationId.toString()) +
          "&currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}");
      return DeleteCartResponse.fromJson(response.data);
    } catch (error) {
      return DeleteCartResponse.withError(_handleError(error));
    }
  }

  Future<GetAddressResponse> getCustomerAddress() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "customer_address_book?currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}");
      return GetAddressResponse.fromJson(response.data);
    } catch (error) {
      return GetAddressResponse.withError(_handleError(error));
    }
  }

  Future<DeleteAddressResponse> deleteCustomerAddress(int addressId) async {
    try {
      Response response = await _dio.delete(_baseUrl +
          "customer_address_book/" +
          addressId.toString() +
          "?currency=${AppData.currency.currencyId}&language_id=${AppData.language.id}");
      return DeleteAddressResponse.fromJson(response.data);
    } catch (error) {
      return DeleteAddressResponse.withError(_handleError(error));
    }
  }

  Future<AddAddressResponse> addCustomerAddress(
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      String city,
      int countryId,
      int state_id,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response = await _dio.post(_baseUrl + "customer_address_book",
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "company": company,
            "street_address": streetAddress,
            "suburb": suburb,
            "postcode": postCode,
            "dob": dob,
            "city": city,
            "country_id": countryId,
            "state_id": state_id,
            "latlong": lat + "," + lng,
            "is_default": 1,
            "phone": phone,
          }));
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error));
    }
  }

  Future<AddAddressResponse> updateCustomerAddress(
      int id,
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      String city,
      int countryId,
      int state_id,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response = await _dio.put(
          _baseUrl + "customer_address_book" + "/" + id.toString(),
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "company": company,
            "street_address": streetAddress,
            "suburb": suburb,
            "postcode": postCode,
            "dob": dob,
            "city": city,
            "country_id": countryId,
            "state_id": state_id,
            "latlong": lat + "," + lng,
            "is_default": 1,
            "phone": phone,
          }));
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error));
    }
  }

  Future<AddAddressResponse> setDefaultCustomerAddress(
      int addressBookID,
      String firstName,
      String lastName,
      String gender,
      String company,
      String streetAddress,
      String suburb,
      String postCode,
      String dob,
      String city,
      int countryId,
      int state_id,
      String lat,
      String lng,
      String phone) async {
    try {
      Response response = await _dio.put(
          _baseUrl + "customer_address_book/" + addressBookID.toString(),
          data: jsonEncode({
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "company": company,
            "street_address": streetAddress,
            "suburb": suburb,
            "postcode": postCode,
            "dob": dob,
            "city": city,
            "country_id": 162,
            "state_id": 167,
            "lattitude": lat,
            "longitude": lng,
            "is_default": 1,
            "phone": phone,
          }));
      return AddAddressResponse.fromJson(response.data);
    } catch (error) {
      return AddAddressResponse.withError(_handleError(error));
    }
  }

  Future<OrderPlaceResponse> placeOrder(
      String billingFirstName,
      String billingLastName,
      String billingStreetAddress,
      String billingCity,
      String billingPostCode,
      int billingCountry,
      int billingState,
      String billingPhone,
      String deliveryFirstName,
      String deliveryLastName,
      String deliveryStreetAddress,
      String deliveryCity,
      String deliveryPostCode,
      int deliveryCountry,
      int deliveryState,
      String deliveryPhone,
      int currencyId,
      int languageId,
      String paymentMethod,
      String latLng,
      String cardNumber,
      String cvc,
      String expMonth,
      String expYear) async {
    try {
      Response response = await _dio.post(_baseUrl + "order",
          data: jsonEncode({
            "billing_first_name": billingFirstName,
            "billing_last_name": billingLastName,
            "billing_street_aadress": billingStreetAddress,
            "billing_city": billingCity,
            "billing_postcode": billingPostCode,
            "billing_country": billingCountry,
            "billing_state": billingState,
            "billing_phone": billingPhone,
            "delivery_first_name": deliveryFirstName,
            "delivery_last_name": deliveryLastName,
            "delivery_street_aadress": deliveryStreetAddress,
            "delivery_city": deliveryCity,
            "delivery_postcode": deliveryPostCode,
            "delivery_country": deliveryCountry,
            "delivery_state": deliveryState,
            "delivery_phone": deliveryPhone,
            "currency_id": currencyId,
            "language_id": languageId,
            "session_id": (AppData.sessionId == null) ? "" : AppData.sessionId,
            "payment_method": paymentMethod,
            "latlong": latLng,
            "payment_id": 0,
            "cc_cvc": cvc,
            "cc_expiry_month": expMonth,
            "cc_expiry_year": expYear,
            "cc_number": cardNumber,
          }));
      return OrderPlaceResponse.fromJson(response.data);
    } catch (error) {
      return OrderPlaceResponse.withError(_handleError(error));
    }
  }

  Future<GetPageResponse> getPage(int pageNo) async {
    try {
      Response response =
          await _dio.get(_baseUrl + "pages/" + pageNo.toString());
      return GetPageResponse.fromJson(response.data);
    } catch (error) {
      return GetPageResponse.withError(_handleError(error));
    }
  }

  Future<OrdersResponse> getOrders() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "customer/order?orderDetail=1&productDetail=1&currency=${AppData.currency.currencyId}");
      print(response.data);
      return OrdersResponse.fromJson(response.data);
    } catch (error) {
      return OrdersResponse.withError(_handleError(error));
    }
  }

  Future<ReviewsResponse> getReviews(int productId) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "review?product_id=" +
          productId.toString() +
          "&language_id=1&customer=1&currency=${AppData.currency.currencyId}");
      return ReviewsResponse.fromJson(response.data);
    } catch (error) {
      return ReviewsResponse.withError(_handleError(error));
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      Response response = await _dio.post(_baseUrl + "forget_password",
          data: jsonEncode({"email": email}));
      return ForgotPasswordResponse.fromJson(response.data);
    } catch (error) {
      return ForgotPasswordResponse.withError(_handleError(error));
    }
  }

  Future<AddReviewResponse> addReview(
      int productId, String comment, double rating) async {
    try {
      Response response = await _dio.post(_baseUrl + "review",
          data: jsonEncode({
            "product_id": productId,
            "comment": comment,
            "rating": rating,
          }));
      return AddReviewResponse.fromJson(response.data);
    } catch (error) {
      return AddReviewResponse.withError(_handleError(error));
    }
  }

  Future<GetWishlistOnStartResponse> getWishlistOnStart() async {
    try {
      Response response = await _dio
          .get(_baseUrl + "wishlist?currency=${AppData.currency.currencyId}");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(_handleError(error));
    }
  }

  Future<GetWishlistOnStartResponse> likeProduct(int productId) async {
    try {
      Response response = await _dio.post(_baseUrl +
          "wishlist?product_id=" +
          productId.toString() +
          "&currency=${AppData.currency.currencyId}");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(_handleError(error));
    }
  }

  Future<GetWishlistOnStartResponse> unLikeProduct(int wishlistId) async {
    try {
      Response response = await _dio.delete(_baseUrl +
          "wishlist/" +
          wishlistId.toString() +
          "?currency=${AppData.currency.currencyId}");
      return GetWishlistOnStartResponse.fromJson(response.data);
    } catch (error) {
      return GetWishlistOnStartResponse.withError(_handleError(error));
    }
  }

  Future<WishlistDetailResponse> getWishlistProducts(int pageNo) async {
    try {
      Response response = await _dio.get(_baseUrl +
          "wishlist?limit=10&getCategory=1&products=1&getDetail=1&language_id=1&currency=${AppData.currency.currencyId}&stock=1&page=" +
          pageNo.toString());
      return WishlistDetailResponse.fromJson(response.data);
    } catch (error) {
      return WishlistDetailResponse.withError(_handleError(error));
    }
  }

  Future<ContactUsResponse> submitContactUs(
      String firstName, String lastName, String email, String message) async {
    try {
      Response response = await _dio.post(_baseUrl +
          "contact-us?first_name=" +
          firstName +
          "&last_name=" +
          lastName +
          "&email=" +
          email +
          "&message=" +
          message);
      return ContactUsResponse.fromJson(response.data);
    } catch (error) {
      return ContactUsResponse.withError(_handleError(error));
    }
  }

  Future<RewardPointsResponse> getRewardPoints() async {
    try {
      Response response = await _dio
          .get(_baseUrl + "points?currency=${AppData.currency.currencyId}");
      return RewardPointsResponse.fromJson(response.data);
    } catch (error) {
      return RewardPointsResponse.withError(_handleError(error));
    }
  }

  Future<RedeemResponse> redeemRewardPoints() async {
    try {
      Response response = await _dio
          .post(_baseUrl + "redeem?currency=${AppData.currency.currencyId}");
      return RedeemResponse.fromJson(response.data);
    } catch (error) {
      return RedeemResponse.withError(_handleError(error));
    }
  }

  Future<FiltersResponse> getFilters() async {
    try {
      Response response = await _dio.get(_baseUrl +
          "attributes?getVariation=1&getDetail=1&page=1&language_id=1&currency=${AppData.currency.currencyId}");
      return FiltersResponse.fromJson(response.data);
    } catch (error) {
      return FiltersResponse.withError(_handleError(error));
    }
  }

  Future<LanguagesResponse> getLanguages() async {
    try {
      Response response =
          await _dio.get(_baseUrl + "language?page=1&limit=100");
      return LanguagesResponse.fromJson(response.data);
    } catch (error) {
      return LanguagesResponse.withError(_handleError(error));
    }
  }

  Future<CurrenciesResponse> getCurrencies() async {
    try {
      Response response = await _dio.get(_baseUrl + "currency");
      return CurrenciesResponse.fromJson(response.data);
    } catch (error) {
      return CurrenciesResponse.withError(_handleError(error));
    }
  }

  Future<UpdateProfileResponse> updateProfile(String firstName, String lastName,
      String password, String confirmPassword) async {
    try {
      Response response = await _dio.put(_baseUrl +
          "profile/" +
          AppData.user.id.toString() +
          "?first_name=" +
          firstName +
          "&last_name=" +
          lastName +
          "&password=" +
          password +
          "&password_confirmation=" +
          confirmPassword);
      return UpdateProfileResponse.fromJson(response.data);
    } catch (error) {
      return UpdateProfileResponse.withError(_handleError(error));
    }
  }

  Future<CountriesResponse> getCountries() async {
    try {
      Response response =
          await _dio.get(_baseUrl + "country?limit=1000&getStates=1");
      return CountriesResponse.fromJson(response.data);
    } catch (error) {
      return CountriesResponse.withError(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
      }
    } else {
      errorDescription = error.toString();
      print(error);
      print(error.stackTrace);
    }
    return errorDescription;
  }
}

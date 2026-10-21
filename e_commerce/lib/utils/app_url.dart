class AppUrl {
  static const String BASE_URL =
      "https://ecomapi.projectnest.store/ecommerce-api";

  static const String URL_LOGIN = "$BASE_URL/user/login";
  static const String URL_SIGNUP = "$BASE_URL/user/registration";
  static const String URL_PROFILE = "$BASE_URL/user/profile";

  // PRODUCT
  static const String URL_PRODUCT = "$BASE_URL/products";
  static const String URL_CATEGORY = "$BASE_URL/categories";

  //
  static const String URL_CREATE_ORDER = "$BASE_URL/product/create-order";
  static const String URL_GET_ORDER = "$BASE_URL/product/get-order ";
  static const String URL_ADD_TO_CART = "$BASE_URL/add-to-cart";
  static const String URL_VIEW_CART = "$BASE_URL/product/view-cart";
  static const String URL_DECREMENT_QTY =
      "$BASE_URL/product/decrement-quantity";
  static const String URL_DELETE = "$BASE_URL/product/delete-cart";
}

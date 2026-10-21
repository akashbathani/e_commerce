import 'package:e_commerce/bloc/cart/view_cart/view_cart_event.dart';
import 'package:e_commerce/bloc/cart/view_cart/view_cart_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/view_cart_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewCartBloc extends Bloc<ViewCartEvent, ViewCartState> {
  ApiService apiService;
  ViewCartBloc({required this.apiService}) : super(ViewCartInitialState()) {
    on<ViewCartFetchEvent>((event, emit) async {
      emit(ViewCartLoadingState());
      print("=====> Loading...");

      try {
        print("=====> try");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null || token.isEmpty) {
          emit(ViewCartFailureState(errorMsg: "token is missing"));
          return;
        }

        var data = await apiService.getApi(
          url: AppUrl.URL_VIEW_CART,
          token: token,
        );
        print("=====> view cart responsee:  ${data.toString()}");

        ViewCartModel viewCartModel = ViewCartModel.fromJson(data);

        if (viewCartModel.status == true) {
          print("=====> ${viewCartModel.status}");

          emit(
            ViewCartILoadedState(
              viewCartData: viewCartModel.viewCartData ?? [],
            ),
          );
        } else {
          emit(
            ViewCartFailureState(
              errorMsg: viewCartModel.message ?? "Cart is Empty",
            ),
          );
        }
      } catch (e) {
        emit(ViewCartFailureState(errorMsg: e.toString()));
      }
    });
  }
}

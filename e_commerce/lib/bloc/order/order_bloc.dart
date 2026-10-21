import 'package:e_commerce/bloc/order/order_event.dart';
import 'package:e_commerce/bloc/order/order_state.dart';
import 'package:e_commerce/helper/api_service/api_service.dart';
import 'package:e_commerce/model/get_order_model.dart';
import 'package:e_commerce/utils/app_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  ApiService apiService;
  OrderBloc({required this.apiService}) : super(OrderInitialState()) {
    on<OrderFetchEvent>((event, emit) async {
      emit(OrderLoadingState());

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");

        if (token == null || token.isEmpty) {
          emit(OrderFailureState(errorMsg: "Token is missing"));
          return;
        }

        final data = await apiService.postApi(
          url: AppUrl.URL_GET_ORDER,
          token: token,
          mBodyoarams: {"user_id": event.userId},
        );

        GetorderModel getOrder = GetorderModel.fromJson(data);

        if (getOrder.status == true) {
          emit(OrderLoadedState(getorderModel: getOrder));
        } else {
          emit(
            OrderFailureState(errorMsg: getOrder.message ?? "No data found."),
          );
        }
      } catch (e) {
        emit(OrderFailureState(errorMsg: e.toString()));
      }
    });
  }
}

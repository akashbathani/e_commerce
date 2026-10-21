import 'package:e_commerce/model/get_order_model.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderLoadedState extends OrderState {
  final GetorderModel getorderModel;
  OrderLoadedState({required this.getorderModel});
}

class OrderFailureState extends OrderState {
  final String errorMsg;
  OrderFailureState({required this.errorMsg});
}

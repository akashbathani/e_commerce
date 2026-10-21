import 'package:e_commerce/model/view_cart_model.dart';

abstract class ViewCartState {}

class ViewCartInitialState extends ViewCartState {}

class ViewCartLoadingState extends ViewCartState {}

class ViewCartILoadedState extends ViewCartState {
  final List<ViewCartData> viewCartData;
  ViewCartILoadedState({required this.viewCartData});
}

class ViewCartFailureState extends ViewCartState {
  final String errorMsg;
  ViewCartFailureState({required this.errorMsg});
}

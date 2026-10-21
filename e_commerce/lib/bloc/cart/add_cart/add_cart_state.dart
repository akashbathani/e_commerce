import 'package:e_commerce/model/add_cart_model.dart';

abstract class AddCartState {}

class AddCartInitialState extends AddCartState {}

class AddCartLoadingState extends AddCartState {}

class AddCartLoadedState extends AddCartState {
  final AddCartModel cartModel;
  AddCartLoadedState({required this.cartModel});
}

class AddCartFailureState extends AddCartState {
  final String errorMsg;
  AddCartFailureState({required this.errorMsg});
}

abstract class ViewCartEvent {}

class ViewCartFetchEvent extends ViewCartEvent {
  final String cartId;
  ViewCartFetchEvent({required this.cartId});
}

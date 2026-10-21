abstract class DeleteCartEvent {}

class DeleteCartEventt extends DeleteCartEvent {
  final String cartId;
  DeleteCartEventt({required this.cartId});
}

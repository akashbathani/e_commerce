abstract class CartEvent {}

class AddCartQuantityEvent extends CartEvent {
  final String userId;
  final String productId;
  final String qty;
  AddCartQuantityEvent({
    required this.productId,
    required this.userId,
    required this.qty,
  });
}

class DecreaseQuantityEvent extends CartEvent {
  final String userId;

  final String productId;
  DecreaseQuantityEvent({required this.userId, required this.productId});
}

class IncreaseQuantityEvent extends CartEvent {
  final String userId;

  final String productId;
  IncreaseQuantityEvent({required this.userId, required this.productId});
}

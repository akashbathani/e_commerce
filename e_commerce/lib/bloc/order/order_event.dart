abstract class OrderEvent {}

class OrderFetchEvent extends OrderEvent {
  final String userId;

  OrderFetchEvent({required this.userId});
}

abstract class DeleteCartState {}

class DeleteCartInitialState extends DeleteCartState {}

class DeleteCartLoadingState extends DeleteCartState {}

class DeleteCartSuccessState extends DeleteCartState {
  final String successMsg;
  DeleteCartSuccessState({required this.successMsg});
}

class DeleteCartFailureState extends DeleteCartState {
  final String errorMsg;
  DeleteCartFailureState({required this.errorMsg});
}

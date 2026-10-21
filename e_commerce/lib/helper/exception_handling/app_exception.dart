class AppException implements Exception {
  String title;
  String msg;

  AppException({required this.title, required this.msg});

  String toErrorMsg() {
    return "$title : $msg";
  }
}

// No internet / Network available nahi hai
class NoInternetException extends AppException {
  NoInternetException({required String errorMsg})
    : super(title: "No Internet Connection", msg: errorMsg);
}

class FetchDataException extends AppException {
  FetchDataException({required String errorMsg})
    : super(title: "Network error", msg: errorMsg);
}

// 401 - Unauthorized
class UnauthorizedException extends AppException {
  UnauthorizedException({required String errorMsg})
    : super(title: "Unauthorized", msg: errorMsg);
}

// 400 - Bad Request
class BadRequestException extends AppException {
  BadRequestException({required String errorMsg})
    : super(title: "Bad Request", msg: errorMsg);
}

// 404 - Not Found
class NotFoundException extends AppException {
  NotFoundException({required String errorMsg})
    : super(title: "Not Found", msg: errorMsg);
}

// 500 - Internal Server Error
class ServerException extends AppException {
  ServerException({required String errorMsg})
    : super(title: "Server Error", msg: errorMsg);
}

// Request timeout
class TimeoutException extends AppException {
  TimeoutException({required String errorMsg})
    : super(title: "Request Timeout", msg: errorMsg);
}

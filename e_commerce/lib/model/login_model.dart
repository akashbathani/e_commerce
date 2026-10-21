class LoginModel {
  bool? status;
  String? message;
  String? tokan;

  LoginModel({this.status, this.message, this.tokan});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tokan = json['tokan'];
  }
}

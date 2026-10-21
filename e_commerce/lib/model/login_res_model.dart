class LoginResModel {
  String? email;
  String? password;

  LoginResModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}

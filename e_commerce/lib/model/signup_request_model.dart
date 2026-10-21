class SignupRequestModel {
  String? name;
  String? mobileNumber;
  String? email;
  String? password;

  SignupRequestModel({this.name, this.mobileNumber, this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "mobile_number": mobileNumber,
      "email": email,
      "password": password,
    };
  }
}

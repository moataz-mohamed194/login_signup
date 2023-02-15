import '../../ domain/entities/login.dart';

class LoginMethod extends Login {
  LoginMethod(
      {required String email,
      required String password,
      String? name,
      String? phoneNumber})
      : super(
            email: email,
            password: password,
            name: name,
            phoneNumber: phoneNumber);

  // factory LoginMethod.fromJson(Map<String, dynamic> json) {
  //   return LoginMethod(
  //       email: json['email'],
  //       password: json['password'],
  //       name: json['name'],
  //       phoneNumber: json['phone']);
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'email': email,
  //     'password': password,
  //     'phoneNumber': phoneNumber,
  //     'name': name
  //   };
  // }
}

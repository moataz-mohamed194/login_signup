import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String email;
  final String password;
  final String? name;
  final String? phoneNumber;

  Login(
      {required this.email,
      required this.password,
      this.name,
      this.phoneNumber});
  @override
  List<Object?> get props => [email, password, name, phoneNumber];
}

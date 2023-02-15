import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../ domain/entities/login.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/string/basic.dart';

abstract class LoginRemoteDataSource {
  Future<Unit> loginMethod(Login login);
  Future<Unit> createAccountMethod(Login login);
}

class LoginRemoteDataSourceImple extends LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImple({required this.client});

  @override
  Future<Unit> loginMethod(Login login) async {
    final body = {
      'email': login.email.toString(),
      'password': login.password.toString()
    };
    try {
      final response =
          await client.post(Uri.parse(BASE_URL + '/auth/login'), body: body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw FailuresLoginException();
      }
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> createAccountMethod(Login login) async {
    try {
      final response = await client.post(Uri.parse('$BASE_URL/auth/register?email=${login.email}&password=${login.password}&phone=${login.phoneNumber}&name=${login.name}'));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Future.value(unit);
      }if (response.statusCode == 401) {
        throw CheckDataException();
      } else {
        throw FailuresLoginException();
      }
    } catch (e) {
      throw OfflineException();
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:muscle_meals/models/result.dart';
import 'package:muscle_meals/utils/url.dart';

class ResetPasswordRepository {
  Future<Result> generateToken(String email) async {
    try {
      final response = await http.post(Uri.parse(ServerUrl.requestPasswordUrl),
          body: {'email': email});
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return SuccessUserResult(data['message']);
      } else {
        return ErrorResult(data['message']);
      }
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  Future<Result> validateToken(String email, String token) async {
    try {
      final response = await http.post(Uri.parse(ServerUrl.validateTokenUrl),
          body: {'email': email, 'token': token});
      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ErrorResult(data['message']);
      }

      return SuccessUserResult(data['message']);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  Future<Result> resetPassword(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(ServerUrl.resetPasswordUrl),
          body: {'email': email, 'password': password});
      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ErrorResult(data['message']);
      }

      return SuccessUserResult(data['message']);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }
}

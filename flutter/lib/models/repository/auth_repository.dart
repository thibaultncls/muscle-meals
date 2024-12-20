import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:muscle_meals/models/result.dart';
import 'package:muscle_meals/models/user.dart';
import 'package:muscle_meals/utils/keys.dart';
import 'package:muscle_meals/utils/url.dart';

class AuthRepository {
  final _storage = const FlutterSecureStorage();

  Future<Result> login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(ServerUrl.loginUrl),
          body: {'email': email, 'password': password});
      final data = jsonDecode(response.body);
      Logger().d(data);
      if (response.statusCode == 200) {
        final user = User.fromJson(data);
        await _storage.write(
            key: LocalKeys.accessToken, value: data['accessToken']);
        final accessKey = await _storage.read(key: 'accessToken');
        Logger().d('accessKey : $accessKey');
        await _storage.write(
            key: LocalKeys.refreshToken, value: data['refreshToken']);
        return SuccessUserResult(data['message'], user: user);
      } else {
        return ErrorResult(data['message']);
      }
    } on Exception catch (e) {
      return ErrorResult(e.toString());
    }
  }

  Future<Result> signIn(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(ServerUrl.registerUrl),
          body: {'email': email, 'password': password});
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await _storage.write(
            key: LocalKeys.accessToken, value: data['accessStorage']);
        await _storage.write(
            key: LocalKeys.refreshToken, value: data['refreshStorage']);
        final user = User.fromJson(data);
        return SuccessUserResult(data['message'], user: user);
      } else {
        return ErrorResult(data['message']);
      }
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  Future<Result> getUser() async {
    try {
      final containsKey =
          await _storage.containsKey(key: LocalKeys.accessToken);

      if (!containsKey) {
        Logger().d('Local storage does not contains the key');
        return ErrorResult('Veuillez vous identifier');
      }

      final token = await _storage.read(key: LocalKeys.accessToken);
      Logger().d('token : $token');

      final response = await http.get(Uri.parse(ServerUrl.userUrl), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      final data = jsonDecode(response.body);
      Logger().d(data);

      if (response.statusCode == 403) {
        return RefreshTokenResult(data['message']);
      } else if (response.statusCode == 200) {
        final user = User.fromJson(data);
        return SuccessUserResult(data['message'], user: user);
      }

      return ErrorResult(data['message']);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  Future<Result> refreshToken() async {
    try {
      final containsKey =
          await _storage.containsKey(key: LocalKeys.refreshToken);

      if (!containsKey) {
        return ErrorResult('Pas de clé trouvé');
      }

      final refreshToken = await _storage.read(key: LocalKeys.refreshToken);

      final response = await http.post(Uri.parse(ServerUrl.refreshToken),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $refreshToken'
          });

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ErrorResult(data['message']);
      }

      final user = User.fromJson(data);
      await _storage.write(
          key: LocalKeys.accessToken, value: data['accessToken']);
      await _storage.write(
          key: LocalKeys.refreshToken, value: data['refreshToken']);
      return SuccessUserResult(data['message'], user: user);
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }

  Future<Result> deleteKey() async {
    try {
      await _storage.delete(key: LocalKeys.accessToken);
      await _storage.delete(key: LocalKeys.refreshToken);
      return SuccessUserResult('Vous vous êtes déconnecter');
    } catch (e) {
      return ErrorResult(e.toString());
    }
  }
}

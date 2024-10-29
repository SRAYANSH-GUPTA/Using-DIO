import 'package:dio/dio.dart';
import 'model.dart';
import 'userview.dart';

Future<User> login(String username, String password) async {
  final dio = Dio();
  
  final response = await dio.post(
    'https://dummyjson.com/auth/login',
    data: {
      'username': username,
      'password': password,
      'expiresInMins': 30,
    },
    options: Options(
      headers: {'Content-Type': 'application/json'},
      extra: {
        'withCredentials': true,
      },
    ),
  );

  return User.fromJson(response.data);
}

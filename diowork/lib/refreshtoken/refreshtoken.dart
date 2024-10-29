import 'package:diowork/userlogin/userview.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'model.dart';

class TokenView extends StatelessWidget {
  final String refreshToken;

  TokenView({required this.refreshToken});  

  Future<TokenResponse?> fetchToken() async {
    final dio = Dio();

    if (refreshtoken.isNotEmpty) { // Check that refreshToken is not empty
      try {
        final response = await dio.post(
          'https://dummyjson.com/auth/refresh',
          options: Options(contentType: Headers.jsonContentType),
          data: jsonEncode({
            'refreshToken': refreshtoken,
            'expiresInMins': 30,
          }),
        );

        if (response.statusCode == 200) {
          print('Token response received');
          return TokenResponse.fromJson(response.data);
        } else {
          throw Exception('Failed to refresh token');
        }
      } catch (e) {
        print('Error: $e');
        return null;
      }
    } else {
      print("Refresh token is empty###############################################");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Details'),
      ),
      body: FutureBuilder<TokenResponse?>(
        future: fetchToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final tokenData = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Access Token:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(tokenData.accessToken, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text('Refresh Token:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(tokenData.refreshToken, style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}

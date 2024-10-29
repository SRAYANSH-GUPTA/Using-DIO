import 'package:diowork/userlogin/userview.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'model.dart';

final String refreshToken = refreshtoken;

class TokenView extends StatelessWidget {
  final String refreshToken = accesstoken;

  

  Future<TokenResponse?> fetchToken() async {
    final dio = Dio();

    if(!refreshtoken.isEmpty)
    {
      try {
      final response = await dio.post(
        'https://dummyjson.com/auth/refresh',
        options: Options(contentType: Headers.jsonContentType),
        data: jsonEncode({
          'refreshToken': refreshToken,
          
          'expiresInMins': 30,
        }),
      );

      if (response.statusCode == 200) {
        print('response');
        return TokenResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to refresh token');
      }
    }
    catch (e) {
      print(e);
      return null;
    }
    }
    else
    {
      print("####################################");
      
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

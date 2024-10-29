import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'model.dart'; // Import your UserModel class
import '../userlogin/userview.dart';

class AuthUser extends StatefulWidget {
  const AuthUser({Key? key}) : super(key: key);

  @override
  State<AuthUser> createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser> {
  Future<UserModel> fetchUserData(String accessToken) async {
    final dio = Dio();
    final response = await dio.get(
      'https://dummyjson.com/auth/me',
      options: Options(
        headers: {
          'Authorization': 'Bearer $accesstoken',
        },
      ),
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MzAyMDQwMDcsImV4cCI6MTczMDIwNTgwN30.FNtbvVAAb3dnX55LFv_EC16sJZ_6UILNyoqpDfxxl0I'; // Replace with your actual access token

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth User'),
      ),
      body: FutureBuilder<UserModel>(
        future: fetchUserData(accessToken),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          }

          final userData = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${userData.firstName} ${userData.lastName}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 8),
                Text('Username: ${userData.username}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Email: ${userData.email}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Age: ${userData.age}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Gender: ${userData.gender}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Phone: ${userData.phone}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Image.network(userData.image),
                const SizedBox(height: 8),
                Text('Address: ${userData.address.address}, ${userData.address.city}, ${userData.address.state} ${userData.address.postalCode}', style: const TextStyle(fontSize: 16)),
                // Add more fields as needed
              ],
            ),
          );
        },
      ),
    );
  }
}

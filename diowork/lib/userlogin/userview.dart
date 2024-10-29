import 'package:flutter/material.dart';
import 'model.dart';
import 'viewmodeluserlogin.dart';

String accesstoken = "";
String refreshtoken = "";
String username = "";
String password = "";
class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  Future<User>? userFuture;

  void _login() {
    final username = usernameController.text;
    final password = passwordController.text;
    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        userFuture = login(username, password);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              obscuringCharacter: '*',
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            FutureBuilder<User>(
              future: userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  accesstoken = user.accessToken;
                  username = usernameController.text;
                  password = passwordController.text;
                  refreshtoken = user.refreshToken;
                  print("#####################");
                  print(refreshtoken);
                  return Column(
                    children: [
                      Text('Welcome, ${user.firstName} ${user.lastName}'),
                      Text('Email: ${user.email}'),
                      Image.network(user.image),
                    ],
                  );
                }
                return const Text('No data');
              },
            ),
          ],
        ),
      ),
    );
  }
}

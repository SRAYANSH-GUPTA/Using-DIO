import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'userlogin/userview.dart';
import 'currentauthuser/authuser.dart';
import 'refreshtoken/refreshtoken.dart';
void main() async {
  runApp(const MyApp(),
    );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Dio Trial',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UserLogin(),
    const AuthUser(),
    const Refreshtoken(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 227, 227),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        
      title:const Text('The Dio Task' ,style: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),)),
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme( data: ThemeData(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User Login'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Auth user'),
            BottomNavigationBarItem(icon: Icon(Icons.textsms), label: 'Refresh Auth session'),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          
        ),
      ),
    );
  }
}
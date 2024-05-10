import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samplelogin/src/pages/login.dart';
import 'package:samplelogin/src/pages/map.dart';
import 'package:samplelogin/src/pages/mission.dart';
import 'package:samplelogin/src/pages/mypage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraExample(),
    );
  }
}

class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);
  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (!snapshot.hasData) {
            return LoginWidget();
          } else {
            return _getPage(screenIndex, snapshot.data?.displayName);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Page',
          ),
        ],
        currentIndex: screenIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
      ),
    );
  }

  Widget _getPage(int index, String? displayName) {
    switch (index) {
      case 0:
        return MissionPage();
      case 1:
        return MapSample(title: '');
      case 2:
        return MyPage();
      default:
        return Container(); // 이 경우는 예외 처리를 위해 빈 컨테이너를 반환합니다.
    }
  }
}

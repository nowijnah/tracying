// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:samplelogin/src/pages/provider/CounterModel.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _selectedIndex = 0;
  final TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // 사용자 이름, 점수, 순위 데이터
  String userName = '한지원';
  //int userScore = 300;
  bool state = false;  // 초기 state는 false
  int higherScore = 301;
  int lowerScore = 283;


  @override
  Widget build(BuildContext context){
    int userScore = Provider.of<CounterModel>(context).count;
    List<Widget> _widgetOptions = <Widget>[
    SingleChildScrollView( // 스크롤 가능하게 설정
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text.rich(
            TextSpan(
              text: '', // 부모 TextSpan의 text는 빈 문자열로 설정
              children: <TextSpan>[
                TextSpan(
                  text: userName,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                TextSpan(
                  text: '의 점수는\n',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '$userScore',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                TextSpan(
                  text: '점입니다.\n',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          _buildRankingList(userScore),
          SizedBox(height: 30),
          FilledButton( // 로그아웃 버튼
            onPressed: FirebaseAuth.instance.signOut,
            child: Text("google logout"),
          ),
        ],
      ),
    ),
  ];
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );

  }
  

  Widget _buildRankingList(int userScore) {
    List<Map<String, dynamic>> rankings;
  
  if (userScore < 301) {
    rankings = [
      {'name': '강주헌', 'score': higherScore},
      {'name': userName, 'score': userScore, 'isCurrentUser': true},
      {'name': '강수빈', 'score': lowerScore},
    ];
  } else {
    rankings = [
      {'name': userName, 'score': userScore, 'isCurrentUser': true},
      {'name': '강주헌', 'score': higherScore},
      {'name': '강수빈', 'score': lowerScore},
    ];
  }

    return Column(
      children: rankings.map((ranking) {
        return ListTile(
          leading: Icon(ranking['isCurrentUser'] == true ? Icons.star : Icons.star_border, color: ranking['isCurrentUser'] == true ? Colors.deepPurple : Colors.grey),
          title: Text(
            ranking['name'],
            style: TextStyle(
              fontWeight: ranking['isCurrentUser'] == true ? FontWeight.bold : FontWeight.normal,
              color: ranking['isCurrentUser'] == true ? Colors.deepPurple : Colors.black,
            ),
          ),
          trailing: Text(
            '${ranking['score']} 점',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ranking['isCurrentUser'] == true ? Colors.deepPurple : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
}

class FilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const FilledButton({Key? key, this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

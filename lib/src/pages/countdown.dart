import 'dart:async';
import 'package:flutter/material.dart';
import 'package:samplelogin/src/pages/home.dart';
import 'package:samplelogin/src/pages/provider/CounterModel.dart';

import 'mypage.dart';

import 'package:provider/provider.dart';


class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> with SingleTickerProviderStateMixin {
  int _currentNumber = 5;
  String _message = '';
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);

    // Start countdown
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentNumber > 0) {
        _animationController.forward(from: 0.0); // Restart animation
        setState(() {
          _currentNumber--;
        });
      } else {
        setState(() {
          _message = '끝났습니다\n+5 point';
        });
        timer.cancel();
        // 카운트다운이 완료된 후 MyPage로 이동
        Future.delayed(Duration(seconds: 2), () {
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CameraExample(initialPage: 2)));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<CounterModel>(context, listen: false).increase();
            
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CameraExample()));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyPage()));
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _message.isEmpty
            ? FadeTransition(
          opacity: _animation,
          child: Text(
            '$_currentNumber',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          ),
        )
            : Text(
          _message,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

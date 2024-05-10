import 'package:flutter/material.dart';
import 'dart:async'; // for Timer
import 'countdown.dart';

class QRPage extends StatelessWidget {
  final String imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png';

  @override
  Widget build(BuildContext context) {
    // 5초 후에 countdown.dart 페이지로 이동
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CountdownPage()),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('QR 페이지'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300, // 이미지의 너비
              height: 300, // 이미지의 높이
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl), // 이미지 URL 로드
                  fit: BoxFit.cover, // 이미지를 정사각형에 맞춰서 보여줌
                ),
                borderRadius: BorderRadius.circular(12.0), // 이미지 테두리를 둥글게 만듦
              ),
            ),
            SizedBox(height: 20),
            Text(
              '해당 쓰레기통을 카메라에 QR을 찍어주세요',
              style: TextStyle(
                color: Colors.deepPurple, // deepPurple 색상 적용
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

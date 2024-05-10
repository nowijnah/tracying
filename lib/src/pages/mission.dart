import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samplelogin/src/pages/provider/CounterModel.dart';
import 'camera.dart';

class MissionPage extends StatefulWidget {
  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TrashButton(
                  text: '플라스틱',
                  iconData: Icons.ac_unit,
                ),
                SizedBox(width: 20), // 각 버튼 사이의 간격 조절을 위한 SizedBox
                TrashButton(
                  text: '종이',
                  iconData: Icons.book,
                ),
              ],
            ),
            SizedBox(height: 20), // 버튼 행 간의 간격 조절을 위한 SizedBox
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TrashButton(
                  text: '일반쓰레기',
                  iconData: Icons.delete,
                ),
                SizedBox(width: 20), // 각 버튼 사이의 간격 조절을 위한 SizedBox
                TrashButton(
                  text: '유리',
                  iconData: Icons.hourglass_bottom,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TrashButton extends StatelessWidget {
  final String text;
  final IconData iconData;

  const TrashButton({required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 250,
      child: ElevatedButton(
        onPressed: () {
          // 버튼이 눌렸을 때의 동작 구현
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<CounterModel>(context, listen: false).recycle();
            
          });
          // camera.dart 파일로 이동합니다.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // 둥근 정도 조절
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(iconData, size: 40), // 아이콘 추가
            SizedBox(height: 10), // 아이콘과 텍스트 사이의 간격 조절
            Text(
              text,
              style: TextStyle(fontSize: 16), // 텍스트의 크기를 16로 설정
            ),
          ],
        ),
      ),
    );
  }
}
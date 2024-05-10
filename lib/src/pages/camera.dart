import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:samplelogin/src/pages/map.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image; //이미지 파일 들어가는 변수임
  bool _isImageSelected = false;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _isImageSelected = true;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          _image == null
              ? SizedBox.shrink()
              : Image.file(
                  _image!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
          SizedBox(height: 20),
          Text(
            _isImageSelected ? '이미지 선택됨' : '이미지를 선택해주세요',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: getImage,
                child: Text(_isImageSelected ? '다시 업로드하기' : '사진 업로드하기'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _isImageSelected
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MapSample(title: '',)), // map.dart 파일로 이동
                        );
                      }
                    : null,
                child: Text('업로드'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:samplelogin/src/pages/QR.dart';
import 'package:samplelogin/src/pages/mission.dart';
import 'package:samplelogin/src/pages/provider/CounterModel.dart';
import 'package:syncfusion_flutter_maps/maps.dart'; 

 
class MapSample extends StatefulWidget {
  MapSample({Key? key, required this.title}) : super(key: key);
 
  final String title;
 
  @override
  _MapSampleState createState() => _MapSampleState();
}
 


class _MapSampleState extends State<MapSample> {
  // controller  for move the map in application
  late GoogleMapController _controller;
 
  // this value is first  position when map is start.
  final CameraPosition _initialPosition =
  CameraPosition(target: LatLng(37.24003, 127.081036), zoom: 17.0,);
 
  // Marker list for  places to be marked when clicking on the map
  final List<Marker> markers = [];
 
  addMarker(cordinate) {
    int id = Random().nextInt(100);
 
    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller; //.future 뺐음
    Location location = Location();
    final currentLocation = await location.getLocation();

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(37.24003, 127.081036), // 현재위치 경희대 
        zoom: 18.0,
      ),
    ));
  }

  static final LatLng currentLatLng = LatLng(
    37.24003, 127.081036
  );

  // 현재 위치 반경 표시하기
  static final Circle circle = Circle(
    circleId: CircleId('choolCheckCircle'),
    center: currentLatLng, // 원의 중심이 되는 위치
    fillColor: Colors.blue.withOpacity(0.5), // 원의 색상
    radius: 10, // 원의 반지름 (미터 단위)
    strokeColor: Colors.blue, // 원의 테두리 색
    strokeWidth: 1, // 원의 두께
  );


  void _normalTrashCan() {

    final normalTrashCan = [
      {
        "name": "일반쓰레기1",
        "latitude": 37.24003,
        "longitude": 127.081036,
      },
      {
        "name": "일반쓰레기2",
        "latitude": 37.2412,
        "longitude": 127.08362,
      },
      {
        "name": "일반쓰레기3",
        "latitude": 37.2395,
        "longitude": 127.0837,
      },
      {
        "name": "일반쓰레기4",
        "latitude": 37.24103,
        "longitude": 127.081036,
      },
      {
        "name": "일반쓰레기5",
        "latitude": 37.241242,
        "longitude": 127.08452,
      },
      {
        "name": "일반쓰레기6",
        "latitude": 37.2405,
        "longitude": 127.0817,
      },
    ];
    
    setState(() {
        markers.clear();
        markers.addAll(
        normalTrashCan.map(
        (e) => Marker(
          markerId: MarkerId(e['name'] as String),
          infoWindow: InfoWindow(title: e['name'] as String),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
        ),
      ),
      );
    });
  }

  void _recycleTrashCan() {

    final normalTrashCan = [
      {
        "name": "재활용1",
        "latitude": 37.2400502,
        "longitude": 127.03010292,
      },
      {
        "name": "재활용2",
        "latitude": 37.2512,
        "longitude": 127.072,
      },
      {
        "name": "재활용3",
        "latitude": 37.239534,
        "longitude": 127.080082,
      },
      {
        "name": "재활용4",
        "latitude": 37.240134,
        "longitude": 127.0837342,
      },
      {
        "name": "재활용5",
        "latitude": 37.2411343,
        "longitude": 127.081036,
      },
      {
        "name": "재활용6",
        "latitude": 37.24142,
        "longitude": 127.083422,
      },
      
    ];
    
    setState(() {
        markers.clear();
        markers.addAll(
        normalTrashCan.map(
        (e) => Marker(
          markerId: MarkerId(e['name'] as String),
          infoWindow: InfoWindow(title: e['name'] as String),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
        ),
      ),
      );
    });
  }

  void _foodTrashCan() {

    final normalTrashCan = [
      {
        "name": "음식물1",
        "latitude": 37.2402289,
        "longitude": 127.0231036345,
      },
      {
        "name": "음식물2",
        "latitude": 37.2512345,
        "longitude": 127.08262345,
      },
      {
        "name": "음식물3",
        "latitude": 37.2495534,
        "longitude": 127.0835345,
      },
      {
        "name": "음식물4",
        "latitude": 37.2357,
        "longitude": 127.0824,
      },
      {
        "name": "음식물5",
        "latitude": 37.24114,
        "longitude": 127.081865,
      },
      {
        "name": "음식물6",
        "latitude": 37.2412375,
        "longitude": 127.084204,
      },
    ];
    
    setState(() {
        markers.clear();
        markers.addAll(
        normalTrashCan.map(
        (e) => Marker(
          markerId: MarkerId(e['name'] as String),
          infoWindow: InfoWindow(title: e['name'] as String),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
        ),
      ),
      );
    });
  }

  void _batteryTrashCan() {

    final normalTrashCan = [
      {
        "name": "건전지1",
        "latitude": 37.24053843,
        "longitude": 127.0298,
      },
      {
        "name": "건전지2",
        "latitude": 37.24284,
        "longitude": 127.0862566,
      },
      {
        "name": "건전지3",
        "latitude": 37.23534,
        "longitude": 127.084754,
      },
      {
        "name": "건전지4",
        "latitude": 37.234853,
        "longitude": 127.084345,
      },
      {
        "name": "건전지5",
        "latitude": 37.2414308,
        "longitude": 127.081345,
      },
      {
        "name": "건전지6",
        "latitude": 37.2415264,
        "longitude": 127.093487,
      },
    ];
    
    setState(() {
        markers.clear();
        markers.addAll(
        normalTrashCan.map(
        (e) => Marker(
          markerId: MarkerId(e['name'] as String),
          infoWindow: InfoWindow(title: e['name'] as String),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
        ),
      ),
      );
    });
  }

  void _clothesTrashCan() {

    final normalTrashCan = [
      {
        "name": "의류1",
        "latitude": 37.24103564,
        "longitude": 127.03103646,
      },
      {
        "name": "의류2",
        "latitude": 37.24367,
        "longitude": 127.0896247,
      },
      {
        "name": "의류3",
        "latitude": 37.2395475,
        "longitude": 127.082764,
      },
      {
        "name": "의류4",
        "latitude": 37.239234,
        "longitude": 127.066453,
      },
      {
        "name": "의류5",
        "latitude": 37.2415356,
        "longitude": 127.08153,
      },
      {
        "name": "의류6",
        "latitude": 37.241646,
        "longitude": 127.08492,
      },
    ];
    
    setState(() {
        markers.clear();
        markers.addAll(
        normalTrashCan.map(
        (e) => Marker(
          markerId: MarkerId(e['name'] as String),
          infoWindow: InfoWindow(title: e['name'] as String),
          position: LatLng(
            e['latitude'] as double,
            e['longitude'] as double,
          ),
        ),
      ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    int trash = Provider.of<CounterModel>(context).trashType;
    if(trash==1){
       _recycleTrashCan();
    }
    // trash = 0;
  return Scaffold(
    appBar: AppBar(title: Text("Map Page"),
      ),
    body: Column(
      children: [
        // Top row with buttons
       SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      ElevatedButton(
        onPressed: _normalTrashCan,
        child: Text('일반쓰레기'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue; // 버튼이 눌렸을 때 파란색으로 변경
              }
              return Color.fromARGB(255, 220, 216, 227); // 눌리지 않았을 때 기본색상
            },
          ),
        ),
      ),
      ElevatedButton(
        onPressed: _recycleTrashCan,
        child: Text('재활용'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue; // 버튼이 눌렸을 때 파란색으로 변경
              }
              return Color.fromARGB(255, 220, 216, 227); // 눌리지 않았을 때 기본색상
            },
          ),
        ),
      ),
      ElevatedButton(
        onPressed: _foodTrashCan,
        child: Text('음식물'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue; // 버튼이 눌렸을 때 파란색으로 변경
              }
              return Color.fromARGB(255, 220, 216, 227); // 눌리지 않았을 때 기본색상
            },
          ),
        ),
      ),
      ElevatedButton(
        onPressed: _batteryTrashCan,
        child: Text('건전지'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue; // 버튼이 눌렸을 때 파란색으로 변경
              }
              return Color.fromARGB(255, 220, 216, 227); // 눌리지 않았을 때 기본색상
            },
          ),
        ),
      ),
      ElevatedButton(
        onPressed: _clothesTrashCan,
        child: Text('옷'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue; // 버튼이 눌렸을 때 파란색으로 변경
              }
              return Color.fromARGB(255, 220, 216, 227); // 눌리지 않았을 때 기본색상
            },
          ),
        ),
      ),
    ],
  ),
),
        Expanded(
          child: GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                _controller = controller;
              });
            },
            markers: markers.toSet(),
            circles: Set.from([_MapSampleState.circle]),
                    myLocationEnabled: true,
          ),
        ),
      ],
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: Padding(
      padding: EdgeInsets.only(bottom: 16.0), // 하단 여백 조절
      child: FloatingActionButton(
        onPressed: trash == 1 ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRPage()),
          );
        } : null, // trash가 1이 아닌 경우에는 onPressed를 null로 설정하여 버튼 비활성화
        backgroundColor: trash == 1 ? Color.fromARGB(255, 223, 195, 231) : Color.fromARGB(255, 195, 191, 191), // trash가 1인 경우 파란색, 아닌 경우 회색으로 설정
        child: Icon(Icons.qr_code),
      ),
    ),
  );
  }
}
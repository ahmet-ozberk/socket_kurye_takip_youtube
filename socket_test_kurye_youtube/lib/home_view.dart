import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:socket_test_kurye_youtube/socket_service.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Location location = new Location();

  late bool _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  double? lat;
  double? lon;

  void getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    location.onLocationChanged.listen((event) {
      setState(() {
        lat = event.latitude;
        lon = event.longitude;
      });
      Map sendData = {
        'lat': event.latitude,
        'long': event.longitude,
        'orderID': "46"
      };
      SocketService.socket!.emit('courierLoc', sendData);
    });
  }

  // void getData() {
  //   SocketService.socket!.on('courierLocation', (data) {
  //     print("Gelen Data => ${data.toString()}");
  //   });
  // }

  @override
  void initState() {
    SocketService().connected();
    super.initState();
    getLocation();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Page"),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lat => ${lat}",
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
            Text(
              "Lon => ${lon}",
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var locationMessage;

  String latitude="";

   String longitude="";

  void getLocation() async{ 
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    print(permission);
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var  lat=position.latitude;
  var  long=position.longitude;
  latitude="$lat";
  longitude="$long";
  setState(() {
    locationMessage="Latitude: $lat and longitude :$long";
  });

    print(position);
  }

void googleMap()async{
  String googleUrl="https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  if (!await launch(googleUrl)) throw 'Could not launch ';
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      home: Scaffold(appBar: AppBar(title: Text("Weather App"),),
      body: Center(child: Container(
        child: ElevatedButton(onPressed: (){
          getLocation();
          googleMap();
        },child: Text("Get Location"),),
      )),),

    );
  }
}


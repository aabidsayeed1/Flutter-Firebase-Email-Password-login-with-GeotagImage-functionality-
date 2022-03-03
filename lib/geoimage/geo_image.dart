import 'dart:io';
import 'package:geolocator/geolocator.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class GeoImage extends StatefulWidget {
  @override
  State<GeoImage> createState() => _GeoImageState();
}

class _GeoImageState extends State<GeoImage> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String currentAddress = 'Select image to get Location';
  Position? currentposition;

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: Text('GeoImage')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Stack(
            children: [
              Card(
                child: image != null
                    ? Container(
                        width: 300,
                        height: 500,
                        child: Image.file(
                          image!,
                          width: 300,
                          height: 500,
                        ),
                      )
                    : Image.asset('img/profile1.png'),
              ),
              Positioned(
                left: 35,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      currentAddress,
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                    currentposition != null
                        ? Text('Latitude = ' +
                            currentposition!.latitude.toString())
                        : Container(),
                    currentposition != null
                        ? Text('Longitude = ' +
                            currentposition!.longitude.toString())
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 48,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(56),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  textStyle: TextStyle(fontSize: 20)),
              clipBehavior: Clip.antiAlias,
              onPressed: () {
                pickImage();
                _determinePosition();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Pick Gallery',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

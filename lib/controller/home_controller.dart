import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_model.dart';

class HomeController extends GetxController {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool _isError = false;

  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
    update();
  }

  WeatherModel? weatherModel;

  Future<void> getData(String name) async {
    try {
      isLoading = true;
      update();
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        http.Response response = await http.get(
          Uri.parse(
              "https://api.openweathermap.org/data/2.5/weather?q=$name&appid=02899144a5f30adbdc59e58df33411d5&units=metric"),
          // "https://api.openweathermap.org/data/2.5/weather?q=$name&appid=02899144a5f30adbdc59e58df33411d5"),
        );
        final decode = jsonDecode(response.body);
        print("============>$decode");
        weatherModel = WeatherModel.fromJson(decode);
        // print("=============>${weatherModel?.name}");
      } else {
        Fluttertoast.showToast(
            msg: "Your connection are offline",
            fontSize: 20,
            timeInSecForIosWeb: 15,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black45);
      }
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      print("===================>$e");
      isError = true;
    } finally {
      isLoading = false;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // print("========================>$Position");
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> useData(double long, double lat) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        isLoading = true;
        print("higihigigigiug");
        update();

        http.Response response = await http.get(
          Uri.parse(
              "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=c11d9cda8ec35e96922e7f3191a8066a"),
        );

        final decode = jsonDecode(response.body);

        weatherModel = WeatherModel.fromJson(decode);
        print("===================>......$decode");
      } else {
        Fluttertoast.showToast(
            msg: "Your connection are offline",
            fontSize: 20,
            timeInSecForIosWeb: 15,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black45);
      }
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      print("==================>$e");
      isError = true;
    } finally {
      isLoading = false;
    }
  }

  dataStore() async {
    Position position = await _determinePosition();
    print("===========> ${position.longitude}");
    print("===========> ${position.latitude}");
    await useData(position.longitude, position.latitude);
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weatther_controller.dart';
import 'package:weather_app/main.dart';

Future noInternetAlertBox() async {
  Get.dialog(
    // context: navigatorKey.currentContext!,
    AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actions: [ElevatedButton(onPressed: () => Get.back(), child: const Text("Okay"))],
      title: const Text(
        "No Internet Access",
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Your device is not connected to internet please connect it to internet.",
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Future apiErrorAlertBox() async {
  Get.dialog(
    // context: navigatorKey.currentContext!,
    AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actions: [ElevatedButton(onPressed: () => Get.back(), child: const Text("Okay"))],
      title: const Text(
        "Server Error",
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Error from server side. Not able to fetch the response from server.",
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Future locationDeniedAlertBox() async {
  showDialog(
    context: navigatorKey.currentContext!,
    builder:(context) =>  AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.back();
              Geolocator.openAppSettings();
            },
            child: const Text("Okay"))
      ],
      title: const Text(
        "Location Denied",
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Not able to fetch location. Please Enable location services.",
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Future locationInfoAlertBox() async {
  Get.dialog(
    // context: navigatorKey.currentContext!,
    AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
            onPressed: () async {
              Get.back();
              Get.find<WeatherController>().updateLocationPermission(
                  await Geolocator.requestPermission());
            },
            child: const Text("Okay"))
      ],
      title: const Text(
        "Location Information",
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "This app will require your location. Please enable location permission.",
        textAlign: TextAlign.center,
      ),
    ),
  );
}

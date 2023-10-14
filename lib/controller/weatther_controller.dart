import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/view/widget/alert_boxes.dart';
import 'package:weather_app/view/widget/custom_snackbar.dart';

class WeatherController extends GetxController {
  WeatherDataModel? _weatherData;
  bool _isLoading = false;
  LocationPermission _locationPermission = LocationPermission.denied;
  final List<String> _regions = [
    "Los Angeles",
    "New York",
    "London",
    "Moscow",
    "Bangkok",
    "Tokyo",
    "Sydney"
  ];
  List<double>? _regionTemp;

  WeatherDataModel? get weatherData => _weatherData;
  LocationPermission get locationPermission => _locationPermission;
  bool get isLoading => _isLoading;
  List<String> get regions => _regions;
  List<double>? get regionTemp => _regionTemp;

  fetchWeatherData() async {
    _isLoading = true;
    update();
    await checkLocationPermission();
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition();
      final response = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=auto'));
      if (response.statusCode != 200) {
        showCustomSnackbar("Error fetching data from API");
      } else {
        _weatherData = WeatherDataModel.fromJson(jsonDecode(response.body));
      }
      await fetchRegionWeatherData(position.latitude, position.longitude);
    } else {
      locationDeniedAlertBox();
    }
    _isLoading = false;
    update();
  }

  fetchRegionWeatherData(double lat, double lng) async {
    _regionTemp = [];
    var response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=America%2FLos_Angeles'));
    if (response.statusCode != 200) {
      showCustomSnackbar("Error fetching data from API");
    } else {
      _regionTemp?.add(WeatherDataModel.fromJson(jsonDecode(response.body)).currentTemp?.temp ?? 0);
      _regionTemp?.add(weatherData?.dailyTemp?.minTemp?[0] ?? 0);
      _regionTemp?.add(weatherData?.dailyTemp?.minTemp?[1] ?? 0);
      _regionTemp?.add(weatherData?.dailyTemp?.minTemp?[2] ?? 0);
      _regionTemp?.add(weatherData?.dailyTemp?.minTemp?[3] ?? 0);
      _regionTemp?.add(weatherData?.dailyTemp?.minTemp?[4] ?? 0);
      _regionTemp?.add(weatherData?.dailyTemp?.minTemp?[5] ?? 0);
    }
    // response = await http.get(Uri.parse(
    //     'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=America%2FNew_York'));
    // if (response.statusCode != 200) {
    //   showCustomSnackbar("Error fetching data from API");
    // } else {
    //   _regionTemp?.add(WeatherDataModel.fromJson(jsonDecode(response.body)));
    // }
    // response = await http.get(Uri.parse(
    //     'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=Europe%2FLondon'));
    // if (response.statusCode != 200) {
    //   showCustomSnackbar("Error fetching data from API");
    // } else {
    //   _regionTemp?.add(WeatherDataModel.fromJson(jsonDecode(response.body)));
    // }
    // response = await http.get(Uri.parse(
    //     'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=Europe%2FMoscow'));
    // if (response.statusCode != 200) {
    //   showCustomSnackbar("Error fetching data from API");
    // } else {
    //   _regionTemp?.add(WeatherDataModel.fromJson(jsonDecode(response.body)));
    // }
    // response = await http.get(Uri.parse(
    //     'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=Asia%2FBangkok'));
    // if (response.statusCode != 200) {
    //   showCustomSnackbar("Error fetching data from API");
    // } else {
    //   _regionTemp?.add(WeatherDataModel.fromJson(jsonDecode(response.body)));
    // }
    // response = await http.get(Uri.parse(
    //     'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=Asia%2FTokyo'));
    // if (response.statusCode != 200) {
    //   showCustomSnackbar("Error fetching data from API");
    // } else {
    //   _regionTemp?.add(WeatherDataModel.fromJson(jsonDecode(response.body)));
    // }
    // response = await http.get(Uri.parse(
    //     'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lng&current=temperature_2m&daily=temperature_2m_max,temperature_2m_min&timezone=Australia%2FSydney'));
    // if (response.statusCode != 200) {
    //   showCustomSnackbar("Error fetching data from API");
    // } else {
    //   _regionTemp?.add(WeatherDataModel.fromJson(jsonDecode(response.body)));
    // }
  }

  requestPermission() async {
    await locationInfoAlertBox();
  }

  updateLocationPermission(LocationPermission locationPermission) {
    _locationPermission = locationPermission;
    update();
  }

  checkLocationPermission() async {
    updateLocationPermission(await Geolocator.checkPermission());
    update();
  }

  checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      noInternetAlertBox();
    }
  }
}

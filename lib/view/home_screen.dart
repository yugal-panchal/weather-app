import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weatther_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if ([
        LocationPermission.denied,
        LocationPermission.deniedForever,
        LocationPermission.unableToDetermine
      ].contains(Get.find<WeatherController>().locationPermission)) {
        Get.find<WeatherController>().requestPermission();
      }
      Get.find<WeatherController>().fetchWeatherData();
    });
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Screen"), centerTitle: true),
      body: GetBuilder<WeatherController>(
        builder: (weatherController) {
          return weatherController.isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 4),
                                  color: Colors.black12,
                                  blurRadius: 4)
                            ]),
                        child: Column(
                          children: [
                            const Text("Today's Temprature"),
                            const SizedBox(height: 10),
                            Text(
                              "${weatherController.weatherData?.currentTemp?.temp}°C",
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Next 7 Days Temprature", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 120,
                        child: ListView.builder(
                          itemCount: 7,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10,bottom: 10),
                            alignment: Alignment.center,
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      color: Colors.black12,
                                      blurRadius: 4)
                                ]),
                            child: Column(
                              children: [
                                Text(
                                    "Date - ${weatherController.weatherData?.dailyTemp?.dates?[index]}"),
                                const SizedBox(height: 10),
                                Text(
                                  "Max Temp - ${weatherController.weatherData?.dailyTemp?.maxTemp?[index]}°C",
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Min Temp - ${weatherController.weatherData?.dailyTemp?.minTemp?[index]}°C",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Text("Multiple Region Temprature", style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 100,
                        child: ListView.builder(
                          itemCount: 7,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 10,bottom: 10),
                            alignment: Alignment.center,
                            height: 100,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      color: Colors.black12,
                                      blurRadius: 4)
                                ]),
                            child: Column(
                              children: [
                                Text(
                                    "Region - ${weatherController.regions[index]}"),
                                const SizedBox(height: 10),
                                Text(
                                  "Temp -> ${weatherController.regionTemp?[index]}°C",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
              );
        },
      ),
    );
  }
}

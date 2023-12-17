import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/entities/weather.dart';
import 'package:weather_app/services/api_list.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherController extends GetxController {
  var weather;
  var icon;
  var isLoading = false.obs;
  WeatherService weatherService = WeatherService();

  getWeatherData({String? city}) async {
    isLoading.value = true;
    final response =
        await weatherService.getWeather(endPoint: ApiList.weather, city: city);
    if (response != null && response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      weather = Weather.fromJson(jsonResponse);
      final iconResponse = await weatherService.getWeatherIcon(
          endPoint: ApiList.icon, icon: weather.icon);
      if (iconResponse != null && iconResponse.statusCode == 200) {
        List<int> bytes = iconResponse.bodyBytes;
        icon = Image.memory(Uint8List.fromList(bytes));
      }
      isLoading.value = false;
    } else {
      weather = null;
      isLoading.value = false;
      Get.showSnackbar(const GetSnackBar(
        title: 'Error',
        message: 'No data to show',
        duration: Duration(seconds: 3),
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
          weight: 600,
        ),
        // backgroundColor: Color.fromARGB(255, 158, 87, 170),
      ));
    }
  }
}

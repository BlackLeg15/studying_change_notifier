import 'package:flutter/material.dart';

import '../model/weather.dart';

class WeatherChangeNotifier extends ChangeNotifier {
  bool isLoading = false;
  Weather? weather;

  Future getWeather(String cityName) async {
    _setLoading(true);
    await Future.delayed(Duration(seconds: 3));
    if (cityName.isNotEmpty) {
      weather = Weather(cityName, 19.9);
    }
    _setLoading(false);
  }

  _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

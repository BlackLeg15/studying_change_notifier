import 'package:flutter/material.dart';

import '../model/weather.dart';

class WeatherChangeNotifier extends ChangeNotifier {
  bool isLoading = false;
  Weather? weather;

  Future<void> getWeather(String cityName) {
    _setLoading(true);
    return Future.delayed(const Duration(seconds: 3)).then((value) {
      if (cityName.isNotEmpty) weather = Weather(cityName, 19.9);
    }).whenComplete(() => _setLoading(false));
  }

  _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

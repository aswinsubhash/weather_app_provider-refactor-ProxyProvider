import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_weather_provider_refactor/models/custom_error.dart';
import 'package:open_weather_provider_refactor/models/weather.dart';

import '../../repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherProvider with ChangeNotifier {
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;

  final WeatherRepository weatherRepository;
  WeatherProvider({
    required this.weatherRepository,
  });

  Future<void> fetchWeather(String city) async {
    _state = _state.copyWith(status: WeatherStatus.loading);
    notifyListeners();

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);

      _state = _state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      );
    
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(status: WeatherStatus.error, error: e);
     
      notifyListeners();
    }
  }
}

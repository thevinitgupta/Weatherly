import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/enums.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherModel? current;
  WeatherBloc(WeatherState initialState) : super(initialState) {
    if(initialState is CurrentWeatherState){
      current = initialState.current;
    }

    on<WeatherFetchEvent>(_fetchWeatherData);
    on<WeatherInitialEvent>(_buildInitial);
  }

  FutureOr<void> _buildInitial(WeatherEvent event, Emitter<WeatherState> emit){
    emit(WeatherInitial());
  }

  FutureOr<void> _fetchWeatherData(
      WeatherEvent event, Emitter<WeatherState> emit
      ) async{

    if(event is WeatherFetchEvent){
      print(event.location);
      try{
        dynamic data = await http.get(Uri.parse("https://api.weatherapi.com/v1/current.json?key=5234668b46f241fca74112355231704&q=${event.location}&aqi=no"));
        print(data.body);
        Map<String, dynamic> weatherData = jsonDecode(data.body);
        current = WeatherModel.fromJson(weatherData);
      }
      catch(err){
        emit(ErrorWeatherState(error: true));
      }
      emit(new CurrentWeatherState(current: current?? WeatherModel.fromJson({})));
    }
    // emit(WeatherInitial());
  }


}
/*
request : https://api.weatherapi.com/v1/current.json?key=5234668b46f241fca74112355231704&q=Asansol&aqi=no

{
  "location": {
    "name": "Asansol",
    "region": "West Bengal",
    "country": "India",
    "lat": 23.68,
    "lon": 86.98,
    "tz_id": "Asia/Kolkata",
    "localtime_epoch": 1681730792,
    "localtime": "2023-04-17 16:56"
  },
  "current": {
    "last_updated_epoch": 1681730100,
    "last_updated": "2023-04-17 16:45",
    "temp_c": 46.1,
    "temp_f": 115.0,
    "is_day": 1,
    "condition": {
        "text": "Sunny",
        "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
        "code": 1000
  },
  }
}
*/
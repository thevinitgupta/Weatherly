part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable{

}

class WeatherInitial extends WeatherState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherLoadingState extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ErrorWeatherState extends WeatherState{
  bool error;
  ErrorWeatherState({
    required this.error
});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CurrentWeatherState extends WeatherState{
  WeatherModel current;
  CurrentWeatherState({
    required this.current
  }){
    print("New Current Weather State for : ${this.current.location}");
  }

  WeatherModel get weather => current;

  @override
  int get hashCode {
    return 0;
  }
  @override
  // TODO: implement props
  List<Object?> get props => [current];
}
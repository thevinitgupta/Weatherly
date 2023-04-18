part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}
class WeatherInitialEvent extends WeatherEvent{

}
class WeatherFetchEvent extends WeatherEvent{
  final String location;

  WeatherFetchEvent({
    required this.location
});
}
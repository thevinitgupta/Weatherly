
import 'package:equatable/equatable.dart';
import 'package:weather_app/enums.dart';

abstract class CounterEvent extends Equatable {}

class CounterNumEvent extends CounterEvent {
  final CounterEnum counterEnum;

  CounterNumEvent({required this.counterEnum});

  @override
  List<Object> get props => [counterEnum];
}

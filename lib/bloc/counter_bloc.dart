import 'dart:async';

import 'package:bloc/bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';
import 'package:weather_app/enums.dart';
import 'package:http/http.dart' as http;

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  late int counter;

  CounterBloc(CounterState initialState) : super(initialState) {
    if (initialState is DataState) {
      counter = initialState.counter;
    } else {
      counter = 0;
    }
    on<CounterNumEvent>(_modifyState);
  }

  // FutureOr<void> _modifyState(CounterNumEvent event, CounterState emit) async*{
  //     emit(CounterInitial());
  //
  // }


  FutureOr<void> _modifyState(
      CounterNumEvent event, Emitter<CounterState> emit) async {
    emit(CounterLoading());
    try{
      dynamic data = await http.get(Uri.parse("https://api.weatherapi.com/v1/current.json?key=5234668b46f241fca74112355231704&q=Asansol&aqi=no"));
      print(data.body.toString());
    }
    catch(err){
      print(err.toString());
    }

    // // await Future.delayed(Duration(seconds: 2));
    //
    // List<Student> list = [Student(0), Student(1), Student(3), Student(1)];
    // Set<Student> set = {Student(0), Student(1), Student(3), Student(1)};
    //
    // print("List " + list.join(",").toString());
    // print("Set " + set.join(",").toString());
    if (event.counterEnum == CounterEnum.increment) {
      counter++;
    } else if (event.counterEnum == CounterEnum.decrement) {
      counter--;
    } else if (event.counterEnum == CounterEnum.reset) {
      counter = 0;
    }
    emit(DataState(counter: counter));
  }
}

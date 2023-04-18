import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/enums.dart';

import 'models/weather_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: BlocProvider(
          create: (BuildContext context) {
            return WeatherBloc(WeatherInitial());
          },
          child: const MyHomePage(title : "Weather App")),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _cityNameController = TextEditingController();

  @override
  Column buildInitial(_weatherBloc){
    return Column(
        children: [
          Padding(
    padding: EdgeInsets.all(16.0),
    child: TextField(
    controller: _cityNameController,
    decoration: InputDecoration(
    hintText: 'Enter city name',
    suffixIcon: IconButton(
    icon: Icon(Icons.search),
    onPressed: () {
    _weatherBloc.add(WeatherFetchEvent(
    location: _cityNameController.text.trim()));
    _cityNameController.text = "";
    },
    ),
    ),
    ),
    )]);
  }

  @override
  Container buildColumnWithData(WeatherModel weather, WeatherBloc weatherBloc) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            weather.location,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${weather.temp.round()}°C',
            style: TextStyle(fontSize: 80),
          ),
          Image.network(
            'https:${weather.condition.url}',
            scale: 0.5,
          ),
          Text(
            weather.condition.type,
            style: TextStyle(fontSize: 40),
          ),
          FloatingActionButton(
            child: Icon(Icons.arrow_back),
              onPressed: () => weatherBloc.add(WeatherInitialEvent()))
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          print(state);
          if (state is CurrentWeatherState) {
            return buildColumnWithData(state.current, weatherBloc);
          }
          return buildInitial(weatherBloc);
        }

                          // FloatingActionButton(
                          //   child: Icon(Icons.remove),
                          //   onPressed: () {
                          //     weatherBloc.add(WeatherFetchEvent(location: "Gurgaon"));
                          //         // .add(CounterNumEvent(counterEnum: CounterEnum.decrement));
                          //   },
                          // ),
                          // FloatingActionButton(
                          //   child: Icon(Icons.restart_alt),
                          //   onPressed: () {
                          //     counterBloc
                          //         .add(CounterNumEvent(counterEnum: CounterEnum.reset));
                          //   },
                          // ),
                          // FloatingActionButton(
                          //   child: Icon(Icons.add),
                          //   onPressed: () {
                          //     counterBloc
                          //         .add(CounterNumEvent(counterEnum: CounterEnum.increment));
                          //   },
                          // ),
      ),
    );
  }
}

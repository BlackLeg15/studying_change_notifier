import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'change_notifier/weather_change_notifier.dart';
import 'model/weather.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Studying State Management"),
      ),
      body: Center(
        child: Consumer<WeatherChangeNotifier>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(child: const CircularProgressIndicator());
            }
            if (controller.weather != null) {
              return buildColumnWithData(controller.weather);
            }
            return buildInitialInput();
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() => const Center(
        child: const CityInputField(),
      );
  Column buildColumnWithData(Weather? weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather?.cityName ?? "",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "${weather?.temperatureInCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        const CityInputField(),
      ],
    );
  }
}

var cityName = '';

void submitCityName(BuildContext context, String cityName) {
  final controller = context.read<WeatherChangeNotifier>();
  controller.getWeather(cityName);
  cityName = '';
}

class CityInputField extends StatelessWidget {
  const CityInputField();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextField(
          key: const Key("city-field"),
          onSubmitted: (value) => submitCityName(context, value),
          textInputAction: TextInputAction.search,
          onChanged: (value) => cityName = value,
          decoration: InputDecoration(
            hintText: "Digite o nome de uma cidade",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: InkWell(
              key: const Key('submit'),
              child: const Icon(Icons.search),
              onTap: () => submitCityName(context, cityName),
            ),
          ),
        ),
      ),
    );
  }
}

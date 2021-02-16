import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/home/change_notifier/weather_change_notifier.dart';
import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Change Notifier',
      home: ChangeNotifierProvider(
        child: HomePage(),
        create: (_) => WeatherChangeNotifier(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:open_weather_provider_refactor/pages/search_page.dart';
import 'package:open_weather_provider_refactor/pages/settings_page.dart';
import 'package:open_weather_provider_refactor/widgets/show_weather.dart';
import 'package:provider/provider.dart';

import '../providers/weather/weather_provider.dart';
import '../widgets/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  late final WeatherProvider _weatherProv;

  @override
  void initState() {
    _weatherProv = context.read<WeatherProvider>();
    _weatherProv.addListener(_registerListener);
    super.initState();
  }

  @override
  void dispose() {
    _weatherProv.removeListener(_registerListener);
    super.dispose();
  }

  void _registerListener() {
    final WeatherState ws = context.read<WeatherProvider>().state;

    if (ws.status == WeatherStatus.error) {
      errorDialog(context, ws.error.errMsg);
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchWeather();
  // }

  // _fetchWeather() {
  //  WidgetsBinding.instance.addPostFrameCallback((_) {
  //    context.read<WeatherProvider>().fetchWeather('London');
  //  });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchPage(),
                ),
              );

              if (_city != null) {
                if (!mounted) return;
                context.read<WeatherProvider>().fetchWeather(_city!);
              }
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) {
                  return const SettingsPage();
                },
              ));
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: showWeather(context),
    );
  }
}

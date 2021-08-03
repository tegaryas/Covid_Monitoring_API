import 'package:covid_monitoring_indo/providers/indo_provider.dart';
import 'package:covid_monitoring_indo/providers/province_provider.dart';
import 'package:covid_monitoring_indo/providers/rumah_sakit_provider.dart';
import 'package:covid_monitoring_indo/screens/home_sceens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => IndoProvider()),
          ChangeNotifierProvider(create: (_) => ProvinceProvider()),
          ChangeNotifierProvider(create: (_) => RumahSakitProvider()),
        ],
        child: HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_review/provider/check_wifi.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/screens/app/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderHome(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckWifi(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

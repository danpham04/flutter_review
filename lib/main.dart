import 'package:flutter/material.dart';
import 'package:flutter_review/provider/provider_connectivity.dart';
import 'package:flutter_review/provider/provider_create.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/provider/provider_update.dart';
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
          create: (context) => ProviderUpdate(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderCreate(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderConnectivity(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

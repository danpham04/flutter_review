import 'package:flutter/material.dart';
import 'package:flutter_review/provider/connect_provider.dart';
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
         StreamProvider(
          create: (context) => ConnectProvider().controller.stream,
          initialData: NetworkStatus.online)
      ],
      child: const MyApp(),
    ),
  );
}

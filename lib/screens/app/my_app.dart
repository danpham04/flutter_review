import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/provider/notification_handler.dart';
import 'package:flutter_review/provider/provider_connectivity.dart';
import 'package:flutter_review/provider/provider_create.dart';
import 'package:flutter_review/provider/provider_home.dart';
import 'package:flutter_review/provider/provider_update.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationHandler.instance(),
        )
      ],
      child: const MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

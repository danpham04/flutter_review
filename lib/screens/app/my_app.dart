import 'package:flutter/material.dart';
import 'package:flutter_review/global/app_routes.dart';
import 'package:flutter_review/provider/connect_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<NetworkStatus>(
      create: (_) => ConnectProvider().controller.stream,
      initialData: NetworkStatus.online,
      child: MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Consumer<NetworkStatus>(
            builder: (context, networkStatus, child) {
              return Stack(
                children: [
                  const Navigator(
                    onGenerateRoute: AppRoutes.onGenerateRoute,
                  ),
                  if (networkStatus == NetworkStatus.offline)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(5.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.public, color: Colors.white),
                            SizedBox(
                                width: 5), // Thêm khoảng cách giữa Icon và Text
                            Text(
                              'No Internet Connection',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

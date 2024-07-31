import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckWifi extends ChangeNotifier{
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  
  void chechWifiApp(BuildContext context){
    initConnectivity(context);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    
    _connectionStatus = result;
    notifyListeners();
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  Future<void> initConnectivity(BuildContext context) async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      // return;
      rethrow ;
    }
    if (!context.mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
}
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ProviderConnectivity extends ChangeNotifier {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final Connectivity _connectivity = Connectivity();
  String messConnect = 'Không có thay đổi';

  ProviderConnectivity() {
    _subscription =
        _connectivity.onConnectivityChanged.listen(_connectionStatus);
  }

  void _connectionStatus(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile)) {
      messConnect = 'Quay lại trực tuyến \n Đang sử dụng dữ liệu di động';
    } else if (result.contains(ConnectivityResult.wifi)) {
      messConnect = 'Quay lại trực tuyến \n Đang sử dụng wifi';
    } else {
      messConnect = ' Bạn đang không có kết nối mạng';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

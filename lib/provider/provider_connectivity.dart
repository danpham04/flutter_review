// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';

// class ProviderConnectivity extends ChangeNotifier {
//   late StreamSubscription<List<ConnectivityResult>> _subscription;
//   final Connectivity _connectivity = Connectivity();
//   String messConnect = 'Kiểm tra kết nối';
//   bool check = false;

//   ProviderConnectivity() {
//     _subscription =
//         _connectivity.onConnectivityChanged.listen(_connectionStatus);
//   }

//   void _connectionStatus(List<ConnectivityResult> result) {
//     if (result.contains(ConnectivityResult.mobile)) {
//       messConnect = 'Bạn Đang sử dụng dữ liệu di động';
//       check = true;
//     } else if (result.contains(ConnectivityResult.wifi)) {
//       messConnect = 'Bạn Đang sử dụng wifi';
//       check = true;
//     } else if(result.contains(ConnectivityResult.none)){
//       messConnect = 'Bạn đang không có kết nối mạng';
//       check = false;
//     }else{
//       messConnect = 'Có lỗi sảy ra';
//     }
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
// }

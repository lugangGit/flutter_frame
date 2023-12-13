import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil{
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> isWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi){
      return true;
    }
    return false;
  }
}


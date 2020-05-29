import 'package:InfoCNCA/helpers/location.dart';

class AppData {
  static final AppData _appData = new AppData._internal();
  
  

  String email;
  UserLocation location;
  String rol;
  factory AppData() {
    return _appData;
  }
  AppData._internal();
}
final appData = AppData();
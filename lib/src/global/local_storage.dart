import 'package:localstorage/localstorage.dart';

import '../widget/const/app_const.dart';

class AppStorage {
  static final LocalStorage cfg = LocalStorage(AppConst.name);
  static String username = '';
}

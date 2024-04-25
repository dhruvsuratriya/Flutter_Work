import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage box = GetStorage();

  static Future<void> setUserId(String value) async {
    await box.write("name", value);
  }

  static getUserId() {
    return box.read('name');
  }
}

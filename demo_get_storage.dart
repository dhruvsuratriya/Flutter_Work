import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DemoGetStorage extends StatefulWidget {
  const DemoGetStorage({super.key});

  @override
  State<DemoGetStorage> createState() => _DemoGetStorageState();
}

class _DemoGetStorageState extends State<DemoGetStorage> {
  static GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // PreferenceManager.setUserId("abcd");
              await box.write('uid', "xyz");
            },
            child: Text('Add'),
          ),
          ElevatedButton(
            onPressed: () {
              // String userid = PreferenceManager.getUserId();
              log('Name ${box.read('uid')}');
              log('UID ${box.read('userId')}');
            },
            child: Text('Get'),
          ),
          ElevatedButton(
            onPressed: () {
              // String userid = PreferenceManager.getUserId();
              box.remove("name");
            },
            child: Text('Remove'),
          ),
          ElevatedButton(
            onPressed: () {
              // String userid = PreferenceManager.getUserId();

              box.erase();
            },
            child: Text('Erase'),
          ),
        ],
      ),
    );
  }
}

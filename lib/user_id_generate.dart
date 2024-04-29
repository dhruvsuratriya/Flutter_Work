import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserIdProvider extends ChangeNotifier {
  String _userId = '';

  String get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners(); // Notify listeners when the user ID is updated
  }
}

class HomeScreenS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulating receiving user ID from console
            String userId =
                '123456'; // Replace with actual user ID from console
            context.read<UserIdProvider>().setUserId(userId);
          },
          child: Text('Receive User ID'),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = context.watch<UserIdProvider>().userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('User ID: $userId'),
      ),
    );
  }
}

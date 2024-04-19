import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('URL Launcher Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _launchURL();
            },
            child: Text('Launch URL'),
          ),
        ),
      ),
    );
  }

  // Function to launch the URL
  _launchURL() async {
    const url = 'https://example.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

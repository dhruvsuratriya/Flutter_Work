
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


class CheckInternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget ;
  const CheckInternetConnectionWidget({
    Key? key,
    required this.snapshot,
    required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return Center(child: const Text('Not connected'));
          default:
            return  widget;
        }
        break;
      default:
        return const Text('');
    }
  }
}


class InternetConnectivityScreen extends StatelessWidget {
  InternetConnectivityScreen({Key? key}) : super(key: key);

  List<Color> colors = [Colors.redAccent, Colors.purple , Colors.pinkAccent, Colors.black, Colors.teal, Colors.green, Colors.grey];
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity =  Connectivity() ;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Internet Connectivity'),
      ),
      body: SafeArea(
        child: StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (_, snapshot){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CheckInternetConnectionWidget(
                snapshot: snapshot,
                widget: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: 120,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                  color: colors[random.nextInt(7)],
                                  height: 100,
                                  child: Center(child: Text(index.toString()))),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ) ;
          },
        ),
      ),
    );
  }
}


// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class InternetConnection extends StatelessWidget {
//   const InternetConnection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black,
//           title: Text(
//             'Internet Connection',
//             style: TextStyle(fontSize: 22, color: Colors.white),
//           ),
//           centerTitle: true,
//         ),
//         body: Container(
//           margin: EdgeInsets.all(20),
//           height: double.infinity,
//           width: double.infinity,
//           child: StreamBuilder(
//             stream: Connectivity().onConnectivityChanged,
//             builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
//               print(snapshot.toString());
//               if (snapshot.hasData) {
//                 ConnectivityResult? result = snapshot.data;
//                 if (result == ConnectivityResult.mobile) {
//                   return connected('Mobile');
//                 } else if (result == ConnectivityResult.wifi) {
//                   return connected('WIFI');
//                 } else {
//                   return noInternet();
//                 }
//               } else {
//                 return loding();
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Widget loding() {
//   return Center(
//     child: CircularProgressIndicator(
//       valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
//     ),
//   );
// }
//
// Widget connected(String type) {
//   return Center(
//     child: Text(
//       "$type Connected",
//       style: TextStyle(color: Colors.black, fontSize: 22),
//     ),
//   );
// }
//
// Widget noInternet() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Image.asset(
//         'assets/images/internet_conncection-removebg-preview.png',
//       ),
//       Container(
//         child: Text(
//           "No Internet Connection",
//           style: TextStyle(fontSize: 22),
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.only(bottom: 20),
//         child: Text("Check your connection "),
//       )
//     ],
//   );
// }

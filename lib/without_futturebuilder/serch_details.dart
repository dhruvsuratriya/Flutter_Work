import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SerchDetails extends StatefulWidget {
  const SerchDetails({super.key, this.serch});

  final String? serch;

  @override
  State<SerchDetails> createState() => _SerchDetailsState();
}

class _SerchDetailsState extends State<SerchDetails> {
  var date;
  bool loading = false;
  bool error = false;

  Future getproduct() async {
    setState(() {
      loading = true;
    });

    print('VALUE ${widget.serch}');

    try {
      http.Response response = await http.get(
          Uri.parse('https://dummyjson.com/products/search?q=${widget.serch}'));

      if (response.statusCode == 200) {
        date = jsonDecode(response.body);
        setState(() {
          loading = false;
        });

        print('SUCCESS ${date[0]}');
      } else {
        setState(() {
          loading = false;
          error = true;
        });

        print('STATUS ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = true;
      });
      print('ERROR $e');
    }
    return date;
  }

  @override
  void initState() {
    getproduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: error
            ? const Center(
                child: Text('Error'),
              )
            : loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : date['total'] == 0
                    ? const Center(
                        child: Text('No Any Data'),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 2,
                                        childAspectRatio: 0.90),
                                itemCount: date['products'].length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 180,
                                        width: 160,
                                        color: Colors.grey,
                                        child: Image.network(
                                          date['products'][index]['thumbnail'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ));
  }
}

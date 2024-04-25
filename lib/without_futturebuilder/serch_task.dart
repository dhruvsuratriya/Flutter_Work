import 'dart:convert';

import 'package:api_task/without_futturebuilder/serch_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SerchTask extends StatefulWidget {
  const SerchTask({super.key});

  @override
  State<SerchTask> createState() => _SerchTaskState();
}

class _SerchTaskState extends State<SerchTask> {
  TextEditingController controller = TextEditingController();
  var date;
  bool loading = false;
  bool error = false;

  Future getproduct() async {
    setState(() {
      loading = true;
    });

    try {
      http.Response response =
          await http.get(Uri.parse('https://dummyjson.com/products/search?q='));

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              error
                  ? Center(
                      child: Text('Error'),
                    )
                  : loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : date == null
                          ? Center(
                              child: Text('No Any Data'),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      hintText: 'Serch',
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      constraints: const BoxConstraints.expand(
                                          width: 300, height: 50)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkResponse(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SerchDetails(
                                              serch: controller.text),
                                        ));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Serch',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                SingleChildScrollView(
                                  child: GridView.builder(
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
                                                date['products'][index]
                                                    ['thumbnail'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            )
            ],
          ),
        ),
      ),
    );
  }
}

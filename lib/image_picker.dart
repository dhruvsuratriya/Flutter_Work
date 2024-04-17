import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;

  Future pickImage(source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PICK IMAGE'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: image != null
                      ? Image.file(
                          image!,
                          height: 400,
                          width: 400,
                        )
                      : const Padding(
                          padding: EdgeInsets.all(50.0),
                          child: Text(
                            'Select a Image!',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 50),
                          backgroundColor: Colors.green),
                      child: const Text(
                        'Camera',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 50),
                          backgroundColor: Colors.orange),
                      child: const Text(
                        'Gallery',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

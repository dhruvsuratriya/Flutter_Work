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



// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<_ChatScreenState> {
//   List<Message> _messages = [];

//   final TextEditingController _textController = TextEditingController();

//   late File _imageFile;

//   Future<void> _getImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _imageFile = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   void _sendMessage() {
//     if (_textController.text.isNotEmpty || _imageFile != null) {
//       setState(() {
//         _messages.add(
//           Message(
//             text: _textController.text,
//             image: _imageFile,
//             isMe: true,
//           ),
//         );
//         _textController.clear();
//         _imageFile;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat App'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return _buildMessage(_messages[index]);
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.photo),
//                   onPressed: _getImage,
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessage(Message message) {
//     return Row(
//       mainAxisAlignment:
//           message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         if (!message.isMe)
//           CircleAvatar(
//             child: Text('User'),
//           ),
//         if (message.image != null)
//           Image.file(
//             message.image,
//             width: 200,
//             height: 200,
//           ),
//         if (message.text.isNotEmpty)
//           Container(
//             margin: EdgeInsets.all(8.0),
//             padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//             decoration: BoxDecoration(
//               color: message.isMe ? Colors.blue : Colors.grey[300],
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Text(
//               message.text,
//               style:
//                   TextStyle(color: message.isMe ? Colors.white : Colors.black),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class Message {
//   final String text;
//   final File image;
//   final bool isMe;

//   Message({required this.text, required this.image, required this.isMe});
// }

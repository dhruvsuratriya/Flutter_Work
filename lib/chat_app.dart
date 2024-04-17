import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<Message> _messages = [];

  void _sendMessage(Message message) {
    if (message.content.isNotEmpty || message.imageUrl != null) {
      setState(() {
        _messages.add(message);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      _showImageSelectionBottomSheet(File(pickedImage.path));
    }
  }

  void _showImageSelectionBottomSheet(File imageFile) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.file(imageFile),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                      _sendMessage(Message(
                        content: '',
                        imageUrl: imageFile.path,
                      ));
                    },
                    child: Text('Send Image'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  leading: message.imageUrl != null
                      ? Container(
                          height: 100,
                          width: 100,
                          child: Image.file(File(message.imageUrl!)))
                      : null,
                  title: Text(message.content),
                );
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String textMessage = _textController.text.trim();
                    if (textMessage.isNotEmpty) {
                      _sendMessage(Message(
                        content: textMessage,
                        imageUrl: null,
                      ));
                      _textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String content;
  final String? imageUrl;

  Message({required this.content, this.imageUrl});
}

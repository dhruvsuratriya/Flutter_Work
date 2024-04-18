import 'package:flutter/material.dart';

// Data model for items
class Item {
  final String name;
  bool isSelected;

  Item(this.name, {this.isSelected = false});
}

class HomeScreen extends StatelessWidget {
  final List<Item> items = [
    Item('Item 1'),
    Item('Item 2'),
    Item('Item 3'),
    Item('Item 4'),
    Item('Item 5'),
  ];

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Items',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(items[index].name),
                        value: items[index].isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            items[index].isSelected = value!;
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      // Process selected items here
                      List<Item> selectedItems =
                          items.where((item) => item.isSelected).toList();
                      // Do something with selectedItems
                      print('Selected items: $selectedItems');
                    },
                    child: Text('Done'),
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
      appBar: AppBar(title: Text('Bottom Sheet Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showBottomSheet(context),
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItemSelectionScreen(),
    );
  }
}

class ItemSelectionScreen extends StatefulWidget {
  @override
  _ItemSelectionScreenState createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  List<String> selects = [];

  void onItemPressed(String item) {
    setState(() {
      if (selects.contains(item)) {
        selects.remove(item);
      } else {
        selects.add(item);
      }
    });
  }

  void addItem() {
    setState(() {
      _items.add('Item ${_items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Selection'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: addItem,
            child: Text('Add Component'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(overscroll: false),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
                child: Row(
                  children: _items.map((e) {
                    bool isSelected = selects.contains(e);
                    return GestureDetector(
                      onTap: () {
                        onItemPressed(e);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFffca7b),
                                  width: 1,
                                ),
                                color: isSelected
                                    ? Colors.green
                                    : const Color(0xFFffca7b),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Center(
                                  child: Icon(Icons.shopping_bag_outlined)),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              e,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

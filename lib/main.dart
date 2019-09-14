import 'package:flutter/material.dart';
import 'package:todolist/models/item.dart';

void main() => runApp(MyApp());

// stl create a stateless
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  var items = List<Item>();

  HomePage() {
    items = [];

    items.add((Item(title: 'milk', done: false)));
    items.add((Item(title: 'coffe', done: true)));
    items.add((Item(title: 'bread', done: false)));

  }
  
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('Simple TodoList'),
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxtm, int index) {
          final item = widget.items[index];

          return CheckboxListTile(
            title: Text(item.title),
            key: Key(item.title),
            value: item.done,
            onChanged: (value) {
              setState(() {
               item.done = value; 
              });
            },
          );

        },

      ),
    );
  }
}

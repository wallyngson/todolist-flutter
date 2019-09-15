import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todolist/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

   // items.add((Item(title: 'milk', done: false)));
   // items.add((Item(title: 'coffe', done: true)));
   // items.add((Item(title: 'bread', done: false)));

  }
  
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  var newTextCrtl = TextEditingController();

  void addItem() {
    if (newTextCrtl.text.isEmpty) return;
    
    setState(() {
     widget.items.add(
       Item(
         title: newTextCrtl.text,
          done: false)
          );
     newTextCrtl.text = ''; 
    });
  }

  void removeItem(int index) {
    setState(() {
     widget.items.removeAt(index); 
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJSON(x)).toList();

      setState(() {
       widget.items = result; 
      });
    }

  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: TextFormField(
          controller: newTextCrtl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: 'new activity...',
            labelStyle: TextStyle(color: Colors.white, fontSize: 14),
          ),
          cursorColor: Colors.white,
        ),
      ),

      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxtm, int index) {
          final item = widget.items[index];

          return Dismissible(
            child: CheckboxListTile(
            title: Text(item.title),
            value: item.done,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
               item.done = value; 
              });
            },
          ),

          key: Key(item.title),
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.remove_circle, 
              color: Colors.white,)
              ),
            onDismissed: (direction) {
              removeItem(index);
            },
          );
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String uName;
  HomePage({super.key,required  this.uName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(child: Text(widget.uName!,style: TextStyle(fontSize: 25),)),
    );
  }
}

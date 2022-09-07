import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class five extends StatefulWidget {
  const five({Key? key}) : super(key: key);

  @override
  State<five> createState() => _fiveState();
}

class _fiveState extends State<five> {
  List l = [];
  bool status = false;


  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData()
  async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    l=jsonDecode(response.body);

    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View API First")),
      body: status
          ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {

          Map m = l[index];

          return ListTile(
            leading: Text("${m['id']}"),
            title: Text("${m['title']}",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("${m['completed']}"),
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

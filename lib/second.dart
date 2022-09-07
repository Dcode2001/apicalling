import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  List l = [];
  bool status = false;


  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData()
  async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
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
      appBar: AppBar(title: Text("View API Second")),
      body: status
          ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {

          Map m = l[index];

          return ListTile(
            leading: Text("${m['id']}"),
            title: Text("${m['name']}\n${m['email']}",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("${m['body']}"),
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

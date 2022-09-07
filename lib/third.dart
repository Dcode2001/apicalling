import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class third extends StatefulWidget {
  const third({Key? key}) : super(key: key);

  @override
  State<third> createState() => _thirdState();
}

class _thirdState extends State<third> {
  List l = [];
  bool status = false;


  @override
  void initState() {
    super.initState();

    getAllData();
  }

  getAllData()
  async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
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
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

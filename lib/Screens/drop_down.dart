import 'dart:convert';
import 'dart:io';

import 'package:covid19trackerapp/Model/drop_down_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropDownScreen extends StatefulWidget {
  const DropDownScreen({super.key});

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  Future<List<DropDownModel>> getPost() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List;
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropDownModel(
              id: map['id'],
              userId: map['userId'],
              title: map['title'],
              body: map['body']);
        }).toList();
      } else {
        throw Exception('Error Fetching data');
      }
    } on SocketException {
      throw Exception('No Internet');
    }
  }

  var selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drop Down Screen'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<DropDownModel>>(
              future: getPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return DropdownButton(
                      isExpanded: true,
                      hint: Text('Select Value'),
                      value: selectedValue,
                      items: snapshot.data!.map((e) {
                        return DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(e.id.toString()));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      });
                } else {
                  return Text('No data available');
                }
              })
        ],
      ),
    );
  }
}

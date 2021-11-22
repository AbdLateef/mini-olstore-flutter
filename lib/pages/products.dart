import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products extends StatelessWidget {
  const Products({
    Key? key,
  }) : super(key: key);

  final String url = 'https://fakestoreapi.com/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    return json.decode(response.body);
  }
  
  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Store'),
      ),
      body: Container(
        child: Text('test'),
      ),
    );
  }
}
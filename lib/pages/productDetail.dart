import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_olshop/pages/products.dart';


class ProductDetail extends StatelessWidget {

  final Map product;

  ProductDetail({required this.product});

  Future updateStock(id) async {

    String url = 'http://192.168.0.59:3001/products/'+id+'/order';

    final response = await http.put(Uri.parse(url), body: {
      "order": '1'
    });
    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Store'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: Image.network(product['image_url']),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['title'],
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp '+product['price'],
                        style: TextStyle(fontSize: 22),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          product['description'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  updateStock(product['id'].toString()).then((value){
                                    Navigator.push(context, 
                                      MaterialPageRoute(builder: (context) => Products())
                                    );
                                  });
                                }, 
                                child: Text(product['stock'] > 0 ? 'Buy' : 'out of stock')
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini_olshop/pages/productDetail.dart';

class Products extends StatelessWidget {
  const Products({
    Key? key,
  }) : super(key: key);

  // final String url = 'https://fakestoreapi.com/products';
  // final String url = 'http://127.0.0.1:8000/products';
  // android emulator http://10.0.2.2
  final String url = 'http://192.168.0.59:3001/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }
  
  @override
  Widget build(BuildContext context) {
    getProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Store'),
      ),
      // body: FutureBuilder(
      //   future: getProducts(),
      //   builder:(context, AsyncSnapshot snapshot) {
      //     if(snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (context, index) {
      //           return Text(snapshot.data[index]['title']); 
      //         });
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   }
      // )
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            padding: EdgeInsets.all(5),
                            child: Image.network(snapshot.data[index]['image_url'])
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: snapshot.data[index],)));
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(snapshot.data[index]['title'], style: TextStyle(color: Colors.lightBlue),)
                              )
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Rp XXXX', style: TextStyle(fontSize: 11, color: Colors.black54))
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Stok : '+ (snapshot.data[index]['stock']).toString(), style: TextStyle(fontSize: 11, color: Colors.black54))
                              ),  
                            ],
                          )
                        ],
                      )
                    )
                  );
                  //return Text(snapshot.data[index]['title']);
                }
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(child: CircularProgressIndicator());
        },
      )  
    );
  }
}
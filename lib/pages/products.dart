import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products extends StatelessWidget {
  const Products({
    Key? key,
  }) : super(key: key);

  final String url = 'https://fakestoreapi.com/products';
  // android emulator http://10.0.2.2

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
                    //height: 180,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            padding: EdgeInsets.all(5),
                            child: Image.network(snapshot.data[index]['image'])
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(snapshot.data[index]['title'])
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Rp XXXX')
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text('Buy Button')
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
          return Text("Loading...");
        },
      )  
    );
  }
}
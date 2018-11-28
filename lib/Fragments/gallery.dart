import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keshaa_android/Models/gallerymodel.dart';
import 'package:http/http.dart' as http;

class GalleryGrid extends StatefulWidget {
  _GalleryGridState createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  List<GalleryModel> lists = List();

  Future<List<GalleryModel>> fetchPost() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      lists = (datas as List)
          .map((data) => new GalleryModel.fromJson(data))
          .toList();
      return lists;
      // return GalleryModel.fromJson(json.decode(response.body));
    } else {
      // throw Exception("Failed to load photos");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPost(),
      builder: (context, data) {
        print('Has error: ${data.hasError}');
        print('Has data: ${data.hasData}');
        print('Snapshot data: ${data.data}');
        switch (data.connectionState) {
          case ConnectionState.none:

          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.active:
            return Center(
              child: Text('active bt no data'),
            );
          default:
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                    child: Column(
                      children: <Widget>[
                        Card(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 10.0,
                          child: Column(children: <Widget>[
                            // ListTile(
                            //   title: Text(lists[index].title),
                            //   // subtitle: Text(lists[index].id.toString()),
                            //   trailing: Image.network(lists[index].url),
                            // ),

                            Image.network(lists[index].thumbnailUrl,
                                fit: BoxFit.fill),
                          ]),
                        ),
                      ],
                    ));
              },
            );
        }
      },
    );
  }
}

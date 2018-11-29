import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keshaa_android/Models/gallerymodel.dart';
import 'package:http/http.dart' as http;
import 'package:keshaa_android/Pages/herodialogpageroute.dart';

class GalleryGrid extends StatefulWidget {
  _GalleryGridState createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<GalleryGrid> {
  AnimationController _controller;
  Animation _height, _width;
  var _fetchPost;

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
  void initState() {
    super.initState();

    _fetchPost = fetchPost();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    // transformationAnim = BorderRadiusTween(
    //         begin: BorderRadius.circular(150.0),
    //         end: BorderRadius.circular(0.0))
    //     .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    _controller.addListener(() {
      // setState(() {});
    });
    _height = Tween(begin: 150.0, end: 1000.0).animate(_controller);
    _width = Tween(begin: 150.0, end: 300.0).animate(_controller);
    // _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._fetchPost,
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
                String tag = "Image" + index.toString();

                // return GestureDetector(
                //   onTap: () {
                //     if (_controller.isCompleted) {
                //       _controller.reverse();
                //     } else if (_controller.isAnimating) {
                //       _controller.stop();
                //     } else {
                //       _controller.forward();
                //     }
                //   },
                //   child: Center(
                //     child: Container(
                //       width: _width.value,
                //       height: _height.value,
                //       child: Image.network(
                //         lists[0].thumbnailUrl,
                //         // fit: BoxFit.fill,
                //       ),
                //     ),
                //   ),
                // );
                return Hero(
                  tag: tag,
                  child: Container(
                    child: InkWell(
                      child: GridTile(
                          child: Image.network(lists[index].thumbnailUrl)),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return Scaffold(
                        //           // appBar: AppBar(title: Text(tag)),
                        //           body: ImagePage(
                        //               image: Image.network(
                        //                 lists[index].thumbnailUrl,
                        //                 width: 200.0,
                        //                 height: 700,
                        //               ),
                        //               imageTag: tag));
                        //     },
                        //   ),
                        // );
                        Navigator.push(
                          context,
                          HeroDialogRoute(builder: (BuildContext context) {
                            return Center(
                              child: AlertDialog(
                                contentPadding: EdgeInsets.all(0.0),
                                title: Hero(
                                  tag: "hero2",
                                  child: Container()
                                ),
                                content: Container(
                                  child: Hero(
                                      tag: 'hero1',
                                      child: CustomLogo(
                                        imageUrl: lists[index].thumbnailUrl,
                                        size: 500.0,
                                      )),
                                ),
                                actions: <Widget>[
                                  OutlineButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Icon(Icons.close),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ImagePage extends StatefulWidget {
  final Image image;
  final String imageTag;

  ImagePage({this.image, this.imageTag});

  @override
  State<StatefulWidget> createState() => new _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Hero(
          tag: "hero1",
          child: ClipOval(
            child: CustomLogo(
              size: 60.0,
            ),
          ),
        ),
        Hero(
            tag: "hero2",
            child: Material(
              color: Colors.transparent,
              child: Text(
                "Sample Hero",
                style: TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ))
      ],
    );
  }
}

class CustomLogo extends StatelessWidget {
  final double size;
  final String imageUrl;
  CustomLogo({this.size = 700.0,this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: size,
      height: size,
    );
  }
}

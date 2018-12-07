import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:keshaa_android/Models/gallerymodel.dart';
import 'package:http/http.dart' as http;
import 'package:keshaa_android/Pages/herodialogpageroute.dart';

class GalleryGrid extends StatefulWidget {
  _GalleryGridState createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<GalleryGrid> {
  // AnimationController _controller;s
  // Animation _height, _width;
  var _fetchPost;

  List<GalleryModel> lists = List();

  Future<List<GalleryModel>> fetchPost() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      // var datas=body['data'];
      print(datas.toString());
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
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
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
            return new GridWidget(lists: lists);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class GridWidget extends StatefulWidget {
  final List<GalleryModel> lists;
  GridWidget({this.lists});

  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _width, _height;
  Animation<BorderRadius> transformationAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    transformationAnim = BorderRadiusTween(
            begin: BorderRadius.circular(150.0),
            end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    _width = Tween<double>(begin: 150.0, end: 300.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    _height = Tween<double>(begin: 150.0, end: 500.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: widget.lists.length,
      itemBuilder: (BuildContext context, int index) {
        String tag = "Image" + index.toString();

        return Hero(
          tag: tag,
          child: Container(
            child: InkWell(
              child: GridTile(
                  child: Image.network(widget.lists[index].url)),
              onTap: () {
                _controller.forward();
                Navigator.push(
                  context,
                  HeroDialogRoute(builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0.0),
                      // title: Hero(tag: "hero2", child: Container()),
                      content: Hero(
                          tag: 'hero1',
                          child: CustomLogo(
                            imageUrl: widget.lists[index].url,
                            // size: 500.0,
                          )),
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
}

class CustomLogo extends StatelessWidget {
  final double size;
  final String imageUrl;
  CustomLogo({this.size = 500.0, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
        height: size,
        width: size,
        alignment: Alignment.center,
      ),
    );
  }
}

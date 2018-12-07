import 'package:flutter/material.dart';

class ClipImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 90.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ProductDetails extends StatefulWidget {
  final String image;
  final String title;
  final int price;

  ProductDetails({this.image, this.title, this.price});
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final double _imageHeight = 350.0;
  Widget _buildImage() {
    return ClipPath(
      clipper: ClipImage(),
      child: Image.network(
        widget.image,
        fit: BoxFit.fill,
        height: _imageHeight,
        width: double.infinity,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: Row(
        children: <Widget>[
          IconButton(
            color: Color(0xFFF000000),
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                
                widget.title,
                style: TextStyle(
                  color: Color(0xFFF000000),
                  fontWeight: FontWeight.normal,
                  fontSize: 17.0,
                  
                ),
              ),
            ),
          ),
          // Icon(Icons.title),
        ],
      ),
    );
  }

  Widget _buildProductDesc() {
    return Padding(
      padding: EdgeInsets.only(top: _imageHeight),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
                softWrap: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "It was a cold grey day in late November." +
                    "The weather had changed overnight, when a backing wind brought" +
                    "a granite sky and a mizzling rain with it, and although it was " +
                    "now only a little after two o'clock in the afternoon the pallor " +
                    "of a winter evening seemed to have closed upon the hills, " +
                    "cloaking them in mist.",
                style: TextStyle(),
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildImage(),
          _buildHeader(),
          _buildProductDesc(),
        ],
      ),
    );
  }
}

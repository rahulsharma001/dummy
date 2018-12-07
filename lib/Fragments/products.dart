import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:keshaa_android/Models/productmodel.dart';
import 'package:keshaa_android/Pages/product_details.dart';

class ProductGrid extends StatefulWidget {
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List<ProductModel> productList;
  var _saveTempList;

  Future<List<ProductModel>> _fetchProductInfo() async {
    var response =
        await http.get('https://jsonplaceholder.typicode.com/photos');
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      // print(decodedJson);
      productList = (decodedJson as List)
          .map((data) => ProductModel.fromJson(data))
          .toList();
      return productList;
    } else {
      print('Something went wrong');
    }
  }

  @override
    void initState() {
      super.initState();
      _saveTempList=_fetchProductInfo();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _saveTempList,
        builder: (context, data) {
          switch (data.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              return ProductWidget(productList: productList);
          }
        },
      ),
    );
  }
}

class ProductWidget extends StatefulWidget {
  List<ProductModel> productList;
  ProductWidget({this.productList});
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  Widget _productImage(int index) {
    return Card(
      child: Image.network(
        widget.productList[index].productImage,
        fit: BoxFit.fitWidth,
        width: double.infinity,
        height: 300.0,
      ),
    );
  }

  Widget _productDetails(int index) {
    return Card(
      child: ListTile(
        title: Text('data'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;

    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: widget.productList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print('product with index $index clicked');

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProductDetails(
                    image: widget.productList[index].fullProdImage,
                    title: widget.productList[index].title,
                    price: widget.productList[index].price)));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      widget.productList[index].productImage,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                  ),
                  // SizedBox(height: 20.0,),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 2.0, top: 10.0, right: 5.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Text(
                                  // 'Hair Wefts ssds dsd s ds ds ds ds d ',
                                  widget.productList[index].title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          // widget.productList[index].price.toString(),
                          '\$300',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

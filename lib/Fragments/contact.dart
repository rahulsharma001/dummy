import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // double _containerHeight = 300.0;
  Widget _buildTopHeader(double height) {
    return Container(
      decoration: ShapeDecoration(
        // color: Colors.blue,
        image: DecorationImage(
            image: AssetImage('assets/map.png'), fit: BoxFit.cover),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
      ),
      height: height * .40,
      // child: Image.asset('assets/map.png',fit: BoxFit.fitWidth,),
      // width: double.infinity,
      // color: Colors.blue,
    );
  }

  Widget _cardAddress() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0),
          child: Icon(Icons.location_on,size: 40.0,),
        ),
        Expanded(
                  child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:15.0,bottom:15.0),
                child: Text(
                  '45,Laxmi Plaza,Laxmi Indl Estate,' + '\nLink Road,\nAndheri (W)\n',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

   Widget _cardPhone() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0),
          child: Icon(Icons.phone,size: 40.0,),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:15.0,bottom:15.0,left: 20.0),
              child: Text(
                '022 - 26301162',
                softWrap: true,
                style: TextStyle(
                  fontSize: 18.0
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


   Widget _cardEmail() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:18.0),
          child: Icon(Icons.email,size: 40.0,),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:15.0,bottom:15.0,left: 20.0),
              child: Text(
                'info@keshaahair.com',
                softWrap: true,
                style: TextStyle(
                  fontSize: 18.0
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _overlappingCard(double height, double heightPercent, [Widget child]) {
    return Padding(
      padding: EdgeInsets.only(top: height * heightPercent),
      child: Card(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
        elevation: 10.0,
        child: Container(
          // margin: EdgeInsets.only(left:20.0,right:20.0 ),
          height: 100.0,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        _buildTopHeader(_height),
        _overlappingCard(_height, 0.32, _cardAddress()),
        _overlappingCard(_height, 0.50,_cardPhone()),
        _overlappingCard(_height, 0.68,_cardEmail()),
      ],
    );
  }
}

import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('YOUR ORDER CREATED',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          CachedNetworkImage(
            imageUrl: "https://www.nicepng.com/png/detail/13-139694_congratulation-png-congratulations-clip-art.png",
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) =>
                Center(child: Icon(Icons.image)),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  MyApp()), (Route<dynamic> route) => false);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 60,vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              height: 50,
              child: Center(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
          ),


        ],
      ),
    );
  }
}

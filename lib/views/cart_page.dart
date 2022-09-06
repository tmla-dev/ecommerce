// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/view_models/cart_provider.dart';
import 'package:ecommerce/views/checkout_page.dart';
import 'package:ecommerce/widgets/cartItem_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    List<ProductModel> productList = context.watch<CartProvider>().cartItems;
    var quantityMap = context.watch<CartProvider>().itemQuantityMap;
    var subTotal = context.watch<CartProvider>().subTotal;
    var ct = context.watch<CartProvider>().ct;
    var grandTotal = context.watch<CartProvider>().grandTotal;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            ///title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Delivery to',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            ///Address
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                // borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [Text('No-17, Mayynigone, Yangon')],
                  )
                ],
              ),
            ),

            ///Order title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Your Order',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            ///Cart item list
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return CartItem(cartItem: productList[index],);
              },
            ),

            ///subtotal
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    '${subTotal}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            ///CT
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Row(
                children: [
                  Text(
                    'CT',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    '${ct}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            Container(margin:EdgeInsets.symmetric(vertical: 10),height:1,color: Colors.black26,),

            ///Grand Total
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Row(
                children: [
                  Text(
                    'Grand Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text(
                    '${grandTotal}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        height: 70,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child:  GestureDetector(
          onTap: ()async{
            bool success = await Provider.of<CartProvider>(context, listen: false).checkOut();
            if(success){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(),),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            height: 40,
            width: deviceWidth / 2,
            child: Center(
                child: Text(
                  'Check Out',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
        ),
      ),
    );
  }
}

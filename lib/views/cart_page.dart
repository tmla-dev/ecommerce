// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/view_models/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Delete Cart Item Button
                        // GestureDetector(
                        //   onTap: (){
                        //     //toDo: Delete Cart Item
                        //   },
                        //   child: Icon(
                        //       Icons.delete
                        //   ),
                        // ),

                        ///product image
                        CachedNetworkImage(
                          width: deviceWidth / 4.5,
                          imageUrl: "${productList[index].image}",
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.image)),
                        ),

                        Spacer(),

                        ///cart item body
                        Container(
                          width: deviceWidth / 2.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${productList[index].name}',
                                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),
                              ),

                              SizedBox(height: 10,),
                              ///cart item quantity
                              Container(
                                color: Theme.of(context).accentColor,
                                height: 30,
                                width: 100,
                                child: Row(
                                  children: [
                                    ///reduce quantity
                                    GestureDetector(
                                      onTap: () {
                                       ///toDo: decrease quantity
                                      },
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     color: Colors.blue),
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: Text(
                                            '–',
                                            style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ),

                                    ///quantity
                                    Container(
                                      width: 30,
                                      height: 30,
                                      // color: Colors.grey.withOpacity(0.3),
                                      child: Center(
                                        child: Text(
                                          '${quantityMap[productList[index].id.toString()]}',
                                          style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 20),
                                        ),
                                      ),
                                    ),

                                    ///add more quantity
                                    GestureDetector(
                                      onTap: () {
                                        ///toDo: increase
                                      },
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     color: Colors.blue),
                                        width: 35,
                                        height: 35,
                                        child: Center(
                                          child: Text(
                                            '+',
                                            style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Spacer(),

                        ///cart item price*quantity
                        Text('12000',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  );

                  /// temporary commented
                  // return Container(
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       CachedNetworkImage(
                  //         width: deviceWidth/4.5,
                  //         imageUrl: "${productList[index].image}",
                  //         errorWidget: (context, url, error) =>
                  //             Center(child: Icon(Icons.image)),
                  //       ),
                  //
                  //       Container(
                  //         width: deviceWidth/2.2,
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text('${productList[index].id}',style: TextStyle(color: Colors.black54),),
                  //             Text('${productList[index].name}fdfd sfde cd e f d ',style: TextStyle(),),
                  //           ],
                  //         ),
                  //       ),
                  //
                  //       Container(
                  //         child: Column(
                  //           children: [
                  //             Text('${productList[index].amount}',style: TextStyle(),),
                  //           ],
                  //         ),
                  //       )
                  //
                  //       // Text()
                  //     ],
                  //   ),
                  // );
                })
          ],
        ),
      ),
    );
  }
}

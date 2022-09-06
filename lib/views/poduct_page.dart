// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/view_models/cart_provider.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;

  const ProductPage({Key? key, required this.product}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int productQuantity = 1;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                ///product image
                CachedNetworkImage(
                  imageUrl: "${widget.product.image}",
                  fit: BoxFit.fitWidth,
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.image)),
                ),

                ///product name and quantity
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: deviceWidth / 1.8,
                          child: Text(
                            '${widget.product.name}',
                            style: TextStyle(fontSize: 20),
                          )),

                      ///quantity button
                      Container(
                        color: Theme.of(context).accentColor,
                        height: 30,
                        width: 100,
                        child: Row(
                          children: [
                            ///reduce quantity
                            GestureDetector(
                              onTap: () {
                                //decrease product quantity
                                if (productQuantity == 1) {
                                  //you can't decrease to 0
                                } else {
                                  productQuantity -= 1;
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                child: Center(
                                  child: Text(
                                    '–',
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: 25),
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
                                  '${productQuantity}',
                                  style: TextStyle(
                                      color: Theme.of(context).backgroundColor,
                                      fontSize: 20),
                                ),
                              ),
                            ),

                            ///add more quantity
                            GestureDetector(
                              onTap: () {
                                //increase product quantity
                                productQuantity += 1;
                                setState(() {});
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
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontSize: 25),
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

                ///description
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Description',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '${widget.product.description}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),

            ///back button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: 45,
                height: 45,
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            )
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Container(
            decoration: BoxDecoration(
              // color: pink,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${widget.product.amount} MMK',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    //add to cart with desired quantity
                    Provider.of<CartProvider>(context, listen: false)
                        .addCart(widget.product, productQuantity);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    height: 50,
                    width: deviceWidth / 2,
                    child: Center(
                        child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

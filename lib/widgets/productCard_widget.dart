// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.productList, required this.index,
  }) : super(key: key);

  final List<ProductModel> productList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        // borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(children: <Widget>[
        CachedNetworkImage(imageUrl: "${productList[index].image}",errorWidget: (context, url, error) => Center(child: Icon(Icons.image)),),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${productList[index].name}",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2000',
                      style: TextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        //toDo: Add to Cart function
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentColor),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/view_models/cart_provider.dart';
import 'package:ecommerce/views/poduct_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.productList, required this.index,
  }) : super(key: key);

  final List<ProductModel> productList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(product: productList[index],),),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,//Colors.white,
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
                        '${productList[index].amount}',
                        style: TextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          //add to cart with default quantity 1
                          Provider.of<CartProvider>(context, listen: false).addCart(productList[index],1);
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
      ),
    );
  }
}
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/view_models/cart_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartItem extends StatelessWidget {
  final ProductModel cartItem;

  const CartItem({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    var quantityMap = context.watch<CartProvider>().itemQuantityMap;
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
            imageUrl: "${cartItem.image}",
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
                  '${cartItem.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),

                SizedBox(
                  height: 10,
                ),

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
                          //check if quantity is already 1
                          if (quantityMap[cartItem
                              .id
                              .toString()] ==
                              1) {
                            //you can't decrease quantity
                          } else {
                            //decrease quantity
                            Provider.of<CartProvider>(context,
                                listen: false)
                                .updateCart(
                                cartItem, false);
                          }
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
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .backgroundColor,
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
                            '${quantityMap[cartItem.id.toString()]}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .backgroundColor,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      ///add more quantity
                      GestureDetector(
                        onTap: () {
                          //to increase
                          Provider.of<CartProvider>(context,
                              listen: false)
                              .updateCart(cartItem, true);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .backgroundColor,
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

          Spacer(),

          ///cart item price*quantity
          Text(
            '${(cartItem.amount!) * (quantityMap[cartItem.id.toString()]!)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

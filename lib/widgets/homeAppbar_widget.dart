import 'package:ecommerce/view_models/product_provider.dart';
import 'package:ecommerce/views/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isElevation = context.watch<ProductProvider>().isElevation;
    return  AppBar(
      elevation: _isElevation?2:0,
      backgroundColor: Colors.white,
      leading: Icon(
        Icons.sort,
        color: Colors.black87,
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(15),
          child: Badge(
            // badgeContent: Text('2'),
            padding: EdgeInsets.all(5),
            badgeColor: Colors.red,
            child: InkWell(
              onTap: () {
                //toDo: Go to Cart Page
              },
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage(),),
                  );
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        // SizedBox(width: 20,)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}

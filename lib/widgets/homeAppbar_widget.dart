import 'package:flutter/material.dart';
import 'package:badges/badges.dart';


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
      child: Row(
        children: [
          Icon(
            Icons.sort
          ),
          Spacer(),
          Badge(
            // badgeContent: Text('2'),
            padding: EdgeInsets.all(5),
            badgeColor: Colors.red,
            child: InkWell(
              onTap: (){
                //toDo: Go to Cart Page
              },
              child: Icon(Icons.shopping_cart_outlined),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(20);
}

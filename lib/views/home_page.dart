// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart';

import '../widgets/homeAppbar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 2,
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
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          // SizedBox(width: 20,)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text('Recommanded Combo',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        // BoxShadow(
                        //   color: Colors.grey.withOpacity(0.3),
                        //   spreadRadius: 1,
                        //   blurRadius: 2,
                        //   offset: Offset(0, 3), // changes position of shadow
                        // ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      ),
                  child: Stack(children: <Widget>[
                    CachedNetworkImage(
                        imageUrl:
                        "https://beehive-images.hivestage.com/medium/ToWppg0Wchrw8ZMuC4savvRccN0e3NlZ63oXz1Ww.png"),
                    Center(child: Text("someText")),
                  ]),
                );
              },
              itemCount: 20,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

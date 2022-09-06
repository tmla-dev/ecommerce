// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/view_models/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import '../widgets/homeAppbar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProuctList();
    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
          loadMore();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> productList = context.watch<ProductProvider>().products;
    return Scaffold(
      backgroundColor: Colors.white, //Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
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
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListView(
          controller: _controller,
          children: [
            ///gretting
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: RichText(
                text: TextSpan(
                  // text: 'Can you ',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Hello Tamla,',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    TextSpan(
                      text: ' What fruid salad do you want today?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

            ///search box
            TextField(
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Theme.of(context).backgroundColor,
                filled: true,
                hintStyle: TextStyle(fontSize: 15),
                hintText: 'Search products',
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
              onSubmitted: (val) {
                //toDo: Search function here
              },
            ),

            ///title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Recommanded Combo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1/1.5
              ),
              itemBuilder: (BuildContext context, int index) {
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
                    CachedNetworkImage(imageUrl: "${productList[index].image}"),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${productList[index].name}",style: TextStyle(fontSize: 14),),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text('2000',style: TextStyle(),), GestureDetector(
                                onTap: () {
                                  //toDo: Add to Cart function
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Theme.of(context).accentColor),
                                  child: Center(
                                    child: Text('+',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22),),
                                  ),
                                ),
                              )],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              },
              itemCount: productList.length, //productList.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  /// fetch new items on scroll
  void loadMore() async {
    print('try to load');
    bool _isLoadMore = context.read<ProductProvider>().isLoadMore;
    print(_isLoadMore);
    if (_isLoadMore) {
      print('loading');
      Provider.of<ProductProvider>(context, listen: false).getProuctList();
    }
  }
}

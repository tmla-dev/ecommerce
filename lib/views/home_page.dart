// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/view_models/product_provider.dart';
import 'package:ecommerce/widgets/productCard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    _controller.addListener(
      () {
        if (_controller.position.atEdge) {
          bool isTop = _controller.position.pixels == 0;
          if (isTop) {
          } else {
            loadMore();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> productList = context.watch<ProductProvider>().products;
    return Scaffold(
      backgroundColor: Colors.white, //Theme.of(context).backgroundColor,
      appBar: HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: NotificationListener(
          onNotification: (t) {
            if (t is ScrollEndNotification) {
              if (_controller.position.pixels == 0) {
                //hide appbar elevation
                Provider.of<ProductProvider>(context, listen: false)
                    .changeElevation(false);
              } else {
                //show appbar elevation
                Provider.of<ProductProvider>(context, listen: false)
                    .changeElevation(true);
              }
            }
            return true;
          },
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
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

              ///product List
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.45),
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    productList: productList,
                    index: index,
                  );
                },
                itemCount: productList.length, //productList.length,
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// fetch new items on scroll
  void loadMore() async {
    bool _isLoadMore = context.read<ProductProvider>().isLoadMore;
    if (_isLoadMore) {
      Provider.of<ProductProvider>(context, listen: false).getProuctList();
    }
  }
}

import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
  List<ProductModel> _cartItems = [];
  Map<String, int> _itemQuantityMap = {};

  List<ProductModel> get cartItems => _cartItems;
  Map<String, int> get itemQuantityMap => _itemQuantityMap;

  ///add item to Cart
  addCart(ProductModel item,int quantity) async{
    //check if item already exist
    bool exists = _cartItems.any((product) => product.id == item.id);
    if(exists){
      //If item already, add more quantity
      for(ProductModel  product in _cartItems){
        //loop to get the same itek object from list
        if(product.id==item.id){
          //add more quantity to existing item
          int? existingQuantity = _itemQuantityMap["${product.id}"];
          int? newQuantity = existingQuantity!+quantity;
          _itemQuantityMap["${product.id}"] = newQuantity;
        }
      }
    }else{
      //item not exist, add item
      _cartItems.add(item);
      _itemQuantityMap["${item.id}"] = quantity;
    }
    notifyListeners();
  }
}
import 'dart:convert';

import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/order_model.dart';
import 'package:http/http.dart'as http;

class CartProvider with ChangeNotifier{
  List<ProductModel> _cartItems = [];
  Map<String, int> _itemQuantityMap = {};
  double _subTotal = 0;
  double _ct = 0;
  double _grandTotal = 0;

  List<ProductModel> get cartItems => _cartItems;
  Map<String, int> get itemQuantityMap => _itemQuantityMap;
  double get subTotal => _subTotal;
  double get ct => _ct;
  double get grandTotal => _grandTotal;

  ///checkout
  Future<bool> checkOut()async{
    List orderEntries = [];
    for(ProductModel item in _cartItems){
      OrderModel orderEntry = OrderModel(
        productId: item.id,
        productName: item.name,
        amount: item.amount,
        quantity: _itemQuantityMap[item.id.toString()],
        lineTotal: 0,
      );
      orderEntries.add(orderEntry);
    }
    Map data = {
      "orderEntries": orderEntries,
      "subTotal": _subTotal,
      "tax":_ct,
      "total": _grandTotal
    };
    //encode Map to JSON
    var body = json.encode(data);
    
    //get user token
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(baseUrl+'orders');
    var res = await http.post(url, headers: headers, body: body);
    if (res.statusCode == 200) {
      return true;
    }else{
      print(res.statusCode);
      return false;
    }
  }

  ///calculate grandTotal
  calculateGrandtotal(){
    _subTotal = 0;
    for(ProductModel item in _cartItems){
      double intemQuantity = _itemQuantityMap[item.id.toString()]!.toDouble();
      //cart item price* cart item quantity
      double? value = item.amount!*intemQuantity;
      _subTotal+= value;
    }
    //calculate ct
    double value = _subTotal*5;
    _ct = value/100;
    //Subtoal + Tax
    _grandTotal = _subTotal+_ct;
  }

  ///update cart item quantity
  updateCart(ProductModel product, bool isAdd) async{
    //loop to get the desired item
    for(ProductModel item in _cartItems){
      //check if it is the same item
      if(product.id==item.id){
        //to add mre quantity
        if(isAdd){
          int? existingQuantity = _itemQuantityMap["${product.id}"];
          int? newQuantity = existingQuantity!+1;
          _itemQuantityMap["${product.id}"] = newQuantity;
        }
        //to decrease quantity
        else{
          int? existingQuantity = _itemQuantityMap["${product.id}"];
          int? newQuantity = existingQuantity!-1;
          _itemQuantityMap["${product.id}"] = newQuantity;
        }
      }
    }
    calculateGrandtotal();
    notifyListeners();
  }

  ///add item to Cart
  addCart(ProductModel item,int quantity) async{
    //check if item already exist
    bool exists = _cartItems.any((product) => product.id == item.id);
    if(exists){
      //If item already, add more quantity
      for(ProductModel  product in _cartItems){
        //loop to get the same item object from list
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
    calculateGrandtotal();
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier{
  int pageNumber = 0;
  List<ProductModel> _products = [];
  bool _isLoadMore = true;
  bool _isElevation = false;

  bool get isLoadMore => _isLoadMore;
  List<ProductModel> get products => _products;
  bool get isElevation => _isElevation;

  ///change home appbar elevation
  changeElevation(bool value){
    _isElevation = value;
    ChangeNotifier();
  }

  ///get products function
  getProuctList() async {
    //get user token
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    //prepare body
    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
    };
    var params = {
      'page': '$pageNumber',
      'size': '6',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse(baseUrl+'products?$query');
    var res = await http.get(url, headers: headers);
    //check api call status
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      List newProductData= data['content'];
      var newProductList = List<ProductModel>.from(newProductData.map((model)=> ProductModel.fromJson(model)));
      _products = _products+newProductList;
      pageNumber+=1;
      notifyListeners();
    } else {
      var data = jsonDecode(res.body.toString());
      //show popup message to user
      Fluttertoast.showToast(
          msg: "${data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // throw Exception('Failed to Login');
    }
  }

}
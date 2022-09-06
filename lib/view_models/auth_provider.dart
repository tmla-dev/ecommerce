import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/constants.dart';

class AuthProvider with ChangeNotifier{
  bool _isAuth = false;

  bool get isAuth => _isAuth;

  ///checking if user signed in
  checkLogin()async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if(token!=null){
      _isAuth = true;
      // _loading = false;
      notifyListeners();
    }else{
      // _loading = false;
      notifyListeners();
    }
  }

  ///User login function
  loginUser(String username, String password) async {
    //prepare api call
    var headers = {
      'accept': '*/*',
      'Content-Type': 'application/json',
    };
    var data = '{"username":"$username","password":"$password"}';
    var url = Uri.parse(baseUrl+'auth/login');
    var res = await http.post(url, headers: headers, body: data);
    //check api response status
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token',data['token']);
      final String? token = prefs.getString('token');
      print(token!+'goal');
    } else {
      var data = jsonDecode(res.body.toString());
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
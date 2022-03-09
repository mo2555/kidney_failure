import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier{


  String _token;
  DateTime _expire;
  String _uId;
  var durationTimer;
  Timer timer;

  bool get isAuth{
    return Token !=null;
  }

  String get Token{
    if(_expire!=null&&_expire.isAfter(DateTime.now())&&_token!=null)
      return _token;
    return null;
  }

  Future<void> auth(String email,String password,String way)async{
    try{
    Uri url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:$way?key=AIzaSyARx1zIxafij6wrXrBNgv4TPR0UX8uuDVE");

    var res = await http.post(url,body: json.encode({
      'email':email,
      'password':password,
      'returnSecureToken':true
    }));

    var resError = json.decode(res.body);
    if(resError['error']!=null)
      throw '${resError['error']['message']}';
    _expire = DateTime.now().add(Duration(seconds: int.parse(resError['expiresIn'])));
    _token = resError['idToken'];
    _uId = resError['localId'];
    //autoLogout();
    notifyListeners();
    SharedPreferences pre = await SharedPreferences.getInstance();
    var data = json.encode({
      '_expire' : _expire.toIso8601String(),
      '_token' : _token,
      '_uId' : _uId,
    });
    pre.setString('data', data);
    }
    catch(e){
      throw e;
    }
  }

  Future<void> singUp(String email,String password)async{
    return await auth(email, password, 'signUp');//signInWithPassword
  }

  Future<void> login(String email,String password)async{
    return await auth(email, password, 'signInWithPassword');//signInWithPassword
  }

  logout()async{
    _expire = null;
    _token = null;
    notifyListeners();
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.clear();
  }

  autoLogout(){
    if(timer!=null)
      timer.cancel();
    durationTimer = _expire.difference(DateTime.now()).inSeconds;
    timer = Timer(Duration(seconds: durationTimer),logout);
    notifyListeners();
  }

  Future<bool>tryAutoLogin()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    if(!pre.containsKey('data'))
      return false;
    var data = json.decode(pre.getString('data')) as Map<String,Object>;
    var expire = DateTime.parse(data['_expire']);
    if(expire.isBefore(DateTime.now()))
      return false;
    _expire = expire;
    _token = data['_token'];
    _uId =data['_uId'];
    notifyListeners();
    autoLogout();
    return true;
  }

}
import 'dart:convert';

import 'package:api/api/api_settings.dart';
import 'package:api/models/base_responce.dart';
import 'package:api/models/users.dart';
import 'package:http/http.dart'as http;
class UsersAPIControllers{


  Future <List<User>> getUser()async{
    var url =Uri.parse(ApiSettings.USERS);
    var response = await http.get(url);
    if(response.statusCode==200){
      BaseResponce baseResponce =BaseResponce.fromJson(jsonDecode(response.body));
      return baseResponce.list;
    }else if(response.statusCode==400){
      //
    }else{
      //
    }
    return [];

  }
}
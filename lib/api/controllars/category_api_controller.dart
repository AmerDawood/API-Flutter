
import 'dart:convert';

import 'package:api/api/api_settings.dart';
import 'package:api/models/category.dart';
import 'package:http/http.dart'as http;

class CategoryAPIController{

  Future<List<Category>>getCategories ()async{
    var url =Uri.parse(ApiSettings.CATEGORIES);
    var response = await http.get(url);

    if(response.statusCode==200){
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['data']as List;
      return jsonArray.map((jsonObject) => Category.fromJson(jsonObject)).toList();
    }else if(response.statusCode==400){
      //
    }
    return [];

  }

}
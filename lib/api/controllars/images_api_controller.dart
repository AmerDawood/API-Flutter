import 'dart:convert';
import 'dart:io';

import 'package:api/api/api_settings.dart';
import 'package:api/models/student_image.dart';
import 'package:api/prefs/student_preferance_controller.dart';
import 'package:api/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;


typedef ImageUploadResponse = void Function({required bool states ,StudentImage?studentImage
,required String message
});


class ImageApiController  with Helpers{

  Future<List<StudentImage>> images()async{
    var url =Uri.parse(ApiSettings.IMAGES.replaceFirst('{id}', ''));
    var response =await http.get(url,headers: {
      HttpHeaders.authorizationHeader:StudentPreferenceController().token,
    });
    if(response.statusCode==200){
      var dataJsonArray =jsonDecode(response.body)['data'] as List;
      return dataJsonArray.map((e) => StudentImage.fromJson(e)).toList();
    }else
      return [];

  }



  Future<void>uploadImage({required String filePath ,
    required ImageUploadResponse imageUploadResponse
  })async {
    var url =Uri.parse(ApiSettings.IMAGES);
    var request = http.MultipartRequest('POST',url);
    var file = http.MultipartFile.fromPath('image', filePath);
    var response= await request.send();


    response.stream.transform(utf8.decoder).listen((event) {
      if(response.statusCode==201){
        var jsonResponse = jsonDecode(event);
        imageUploadResponse(states: true,
            studentImage: StudentImage.fromJson(jsonResponse['data']),
            message:jsonResponse['message']
        );


      }else if(response.statusCode==400){
        var jsonResponse = jsonDecode(event);
        imageUploadResponse(states: false,
            studentImage: StudentImage.fromJson(jsonResponse['data']),
            message:jsonResponse['message']
        );
      }else{
        imageUploadResponse(
            states: false,

            message:'Something Wrong!!',
        );
      }



    });



  }


   Future <bool>deleteImage({required BuildContext context , required int id})async{
   var url = Uri.parse(ApiSettings.IMAGES.replaceFirst('{id}',id.toString()));
   var response =await http.delete(url,headers: {
     HttpHeaders.authorizationHeader:StudentPreferenceController().token,

   });
   if(response.statusCode==200){
     showSnackBar(context: context, message: jsonDecode(response.body)['message']);

     return true;

   }
   return false;



    
   }



}
import 'dart:convert';
import 'dart:io';
import 'package:api/api/api_settings.dart';
import 'package:api/models/student.dart';
import 'package:api/prefs/student_preferance_controller.dart';
import 'package:api/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class StudentApiController with Helpers {
  Future<bool> login({required String email, required String password}) async {
    var url = Uri.parse(ApiSettings.LOGIN);
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Student student = Student.fromJson(jsonResponse['object']);
      StudentPreferenceController().saveStudent(student: student);
      return true;
    } else if (response.statusCode == 400) {
      //
    }
    return false;
  }



  Future<bool> logout() async {
    var url = Uri.parse(ApiSettings.LOGOUT);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: StudentPreferenceController().token,
      HttpHeaders.acceptHeader: 'application/json',
    });

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      await StudentPreferenceController().loggedOut();
    } else {}
    return false;
  }




  Future<bool> register({
    required BuildContext context,
    required String fullName,
    required String email,
    required String password,
    required String gender,
  }) async {
    var url = Uri.parse(ApiSettings.REGISTER);
    var response = await http.post(url, body: {
      'full_name': fullName,
      'email': email,
      'password': password,
      'gender': gender,
    });
    if (response.statusCode == 201) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],);
      return true;
    } else if (response.statusCode == 400) {
      showSnackBar(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      showSnackBar(
          context: context,
          message: 'something error , try again',
          error: true);
    }
    return false;
  }





  Future<bool> forgetPassword({required BuildContext context ,required String email}) async {
    var url = Uri.parse(ApiSettings.ForgetPassword);
    var response = await http.post(url,body:{'email': email});
    if(response.statusCode==200){
      var jsonObject =jsonDecode(response.body);
      showSnackBar(context: context, message:jsonObject['message']);
      print('code ${jsonObject['code']}');
      return true;

    }else if(response.statusCode==400){
      var jsonObject =jsonDecode(response.body);
      showSnackBar(context: context, message:jsonObject['message'],error: true);
    }else{
      showSnackBar(
          context: context,
          message: 'something error , try again',
          error: true
      );
    }
    return false;

  }



  Future<bool> resetPassword({required
  BuildContext context ,
    required String email,
    required String code,
    required String password,

  }) async {
    var url = Uri.parse(ApiSettings.ResetPassword);
    var response = await http.post(url,body:{
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password,


    });
    if(response.statusCode==200){
      var jsonObject =jsonDecode(response.body);
      showSnackBar(context: context, message:jsonObject['message']);
      return true;

    }else if(response.statusCode==400){
      var jsonObject =jsonDecode(response.body);
      showSnackBar(context: context,
          message:jsonObject['message'],error: true);
    }else{
      showSnackBar(
          context: context,

          message: 'something error , try again',
          error: true
      );
    }
    return false;

  }

}

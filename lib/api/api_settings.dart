

import 'package:api/screens/auth/forget_password.dart';
import 'package:api/screens/auth/reset_password.dart';

class ApiSettings{
  static const _API_URL ='http://demo-api.mr-dev.tech/api/';
  static const USERS = _API_URL + 'users';
  static const CATEGORIES =_API_URL +'categories';
  static const LOGIN =_API_URL +'students/auth/login';
  static const LOGOUT =_API_URL +'students/auth/logout';
  static const REGISTER =_API_URL +'students/auth/register';
  static const ForgetPassword =_API_URL +'students/auth/forget-password';
  static const ResetPassword =_API_URL +'students/auth/reset-password';
  static const IMAGES =_API_URL + 'student/images/{id}';


}
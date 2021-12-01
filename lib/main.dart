import 'package:api/prefs/student_preferance_controller.dart';
import 'package:api/screens/auth/forget_password.dart';
import 'package:api/screens/auth/login_screen.dart';
import 'package:api/screens/auth/register_screen.dart';
import 'package:api/screens/category_screen.dart';
import 'package:api/screens/images/images_screen.dart';
import 'package:api/screens/images/uplode_image_screen.dart';
import 'package:api/screens/launch_screen.dart';
import 'package:api/screens/usres_screen.dart';
import 'package:flutter/material.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await StudentPreferenceController().initSharedPreference();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login_screen',
      routes: {
        '/users_screen':(context)=>UsersScreen(),
        '/category_screen':(context)=>CategoryScreen(),
        '/login_screen':(context)=>LoginScreen(),
        '/register_screen':(context)=>RegisterScreen(),
        '/launch_screen':(context)=>LaunchScreen(),
          // '/reset_password':(context)=>ResetPassword(),
        '/forget_password':(context)=>ForgetPassword(),
        '/image_screen':(context)=>ImageScreen(),
        '/upload_image_screen':(context)=>UploadImageScreen(),

      },
    );
  }
}

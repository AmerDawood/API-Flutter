import 'package:api/api/controllars/student_api_controller.dart';
import 'package:api/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> with Helpers {

  late TextEditingController _fullNameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  String _gender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Register',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            Text(
              'Create account',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter below data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _fullNameEditingController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'full name',
                prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _emailEditingController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordEditingController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'password',
                prefixIcon: Icon(Icons.lock),
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                      value: 'M',
                      title: Text('Male'),
                      groupValue: _gender,
                      onChanged: (String? value) {
                        if(value !=null){
                          setState(() {
                            _gender = value;
                          });
                        }
                      }
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                      value: 'F',
                      title: Text('Female'),
                      groupValue: _gender,
                      onChanged: (String? value) {
                        if(value !=null){
                          setState(() {
                            _gender = value;
                          });
                        }
                      }
                  ),
                ),
              ],
            ),
            ElevatedButton(
              // important
              onPressed: () async => await performRegister(),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Register',
              ),
            ),


          ],
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_fullNameEditingController.text.isNotEmpty &&
        _emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data',error: true);
    return false;
  }

  Future<void> register() async {
    bool status = await StudentApiController().register(
        context: context,
        gender: _gender,
        fullName: _fullNameEditingController.text,
        email: _emailEditingController.text,
        password: _passwordEditingController.text
    );
    if (status) {

      Navigator.pushReplacementNamed(context, '/login_screen');
    } else {
      showSnackBar(context: context, message: 'Login failed', error: true);
    }
  }
}

import 'package:api/api/controllars/student_api_controller.dart';
import 'package:api/prefs/student_preferance_controller.dart';
import 'package:api/screens/auth/login_screen.dart';
import 'package:api/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/widgets.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({Key? key, required this.email}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResetPassword> with Helpers {
  String? _code;

  late TextEditingController _firstCodeEditingController;
  late TextEditingController _secondCodeEditingController;
  late TextEditingController _thirdCodeEditingController;
  late TextEditingController _forthCodeEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _ConfirmpasswordEditingController;

  late FocusNode _firstFocusNote;
  late FocusNode _secondFocusNote;
  late FocusNode _thirdFocusNote;
  late FocusNode _forthFocusNote;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordEditingController = TextEditingController();
    _ConfirmpasswordEditingController = TextEditingController();
    _firstCodeEditingController = TextEditingController();
    _secondCodeEditingController = TextEditingController();
    _thirdCodeEditingController = TextEditingController();
    _forthCodeEditingController = TextEditingController();

    _firstFocusNote = FocusNode();
    _secondFocusNote = FocusNode();
    _thirdFocusNote = FocusNode();
    _forthFocusNote = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordEditingController.dispose();
    _ConfirmpasswordEditingController.dispose();
    _firstCodeEditingController.dispose();
    _secondCodeEditingController.dispose();
    _thirdCodeEditingController.dispose();
    _forthCodeEditingController.dispose();

    _firstFocusNote.dispose();
    _secondFocusNote.dispose();
    _thirdFocusNote.dispose();
    _forthFocusNote.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Reset Password',
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
              'Welcome back',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter code & new password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CodeTextField(
                    onChange: (String value) {
                      if (value.isNotEmpty) _secondFocusNote.requestFocus();
                    },
                    firstCodeEditingController: _firstCodeEditingController,
                    firstFocusNote: _firstFocusNote,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CodeTextField(
                    onChange: (String value) {
                      if (value.isNotEmpty)
                        _thirdFocusNote.requestFocus();
                      else
                        _firstFocusNote.requestFocus();
                    },
                    firstCodeEditingController: _secondCodeEditingController,
                    firstFocusNote: _secondFocusNote,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CodeTextField(
                    onChange: (String value) {
                      if (value.isNotEmpty)
                        _forthFocusNote.requestFocus();
                      else
                        _secondFocusNote.requestFocus();
                    },
                    firstCodeEditingController: _thirdCodeEditingController,
                    firstFocusNote: _thirdFocusNote,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CodeTextField(
                    onChange: (String value) {
                      if (value.isEmpty) _thirdFocusNote.requestFocus();
                    },
                    firstCodeEditingController: _forthCodeEditingController,
                    firstFocusNote: _forthFocusNote,
                  ),
                ),
              ],
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
              height: 10,
            ),
            TextField(
              controller: _ConfirmpasswordEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: ' Confirm password',
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
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async => await performResetPassword(),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Reset Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (checkCode()) {
      if (checkPassword()) {
        return true;
      }
    }

    return false;
  }

  bool checkCode() {
    if (_firstCodeEditingController.text.isNotEmpty &&
        _secondCodeEditingController.text.isNotEmpty &&
        _thirdCodeEditingController.text.isNotEmpty &&
        _forthCodeEditingController.text.isNotEmpty) {
      _code = _firstCodeEditingController.text +
          _secondCodeEditingController.text +
          _thirdCodeEditingController.text +
          _forthCodeEditingController.text;
      return true;
    } else {
      showSnackBar(
          context: context, message: 'Enter Required data', error: true);

      return false;
    }
  }

  bool checkPassword() {
    if (_passwordEditingController.text.isNotEmpty &&
        _ConfirmpasswordEditingController.text.isNotEmpty) {
      if (_passwordEditingController.text ==
          _ConfirmpasswordEditingController.text) {
        return true;
      }
      showSnackBar(
          context: context,
          message: 'Password Confirmation error',
          error: true);
    }
    return false;
  }

  Future<void> resetPassword() async {
    bool status = await StudentApiController().resetPassword(
        context: context,
        email: widget.email,
        code: _code!,
        password: _passwordEditingController.text);
    if (status) Navigator.pop(context);
  }
}

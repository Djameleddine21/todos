import 'package:flutter/material.dart';
import 'package:todos/constants.dart';
import 'package:todos/controller/validator.dart';
import 'package:todos/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  static const String id = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form Key
  GlobalKey<FormState> _formKey;
  //custom validation class
  Validator _validator;
  // if the form is already validate or not, is set to TRUE when user click to login
  bool _alreadyValidate = false;
  //controller of phone number input
  TextEditingController _phoneController;
  //Object of AuthService
  AuthService _authService;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _validator = Validator();
    _authService = AuthService();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true, backgroundColor: greenColor),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          children: <Widget>[
            // Phone number input
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: inputDecoration.copyWith(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone, color: greenColor),
                  hintText: "Your phone number..."),
              validator: _validator.phoneValidator,
              onChanged: (_) {
                if (_alreadyValidate) _formKey.currentState.validate();
              },
            ),
            // login button
            InkWell(
              onTap: () {
                _alreadyValidate = true;
                if (_formKey.currentState.validate()) {
                  _authService.verifyPhone(context, _phoneController.text.trim());
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 40.0),
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: greenColor,
                ),
                child: Text(
                  "LOGIN",
                  style: whiteText.copyWith(fontSize: 20.0, letterSpacing: 1.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

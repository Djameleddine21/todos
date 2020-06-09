import 'package:flutter/material.dart';
import 'package:todos/constants.dart';
import 'package:todos/controller/validator.dart';

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
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _validator = Validator();
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
                _formKey.currentState.validate();
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

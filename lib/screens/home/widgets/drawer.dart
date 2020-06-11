import 'package:flutter/material.dart';
import 'package:todos/constants.dart';
import 'package:todos/screens/login/login_page.dart';
import 'package:todos/services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox.expand(
        child: Container(
          color: greenColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Todos App",
                    style: TextStyle(
                        fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Spacer(),
              Divider(),
              FlatButton(
                onPressed: () {
                  AuthService.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (_) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Logout", style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    Icon(Icons.exit_to_app, color: Colors.white),
                  ],
                ),
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

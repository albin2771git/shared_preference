import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preference/myDashBoard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashBoard()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Shared Preference'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login"),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
            ),
            child: TextField(
              controller: username_controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'username'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 30,
              right: 30,
            ),
            child: TextField(
              controller: password_controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  String username = username_controller.text;
                  String password = password_controller.text;
                  if (username != '' && password != '') {
                    print('Sucessfull');
                    logindata.setBool('login', false);
                    logindata.setString('username', username);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyDashBoard()));
                  }
                },
                child: Text('Login')),
          )
        ],
      )),
    );
  }
}

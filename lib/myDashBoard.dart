import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preference/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({super.key});

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('DashBoard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Text(
                'Hai $username welcome ',
                style: TextStyle(color: Colors.purple, fontSize: 32),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  logindata.setBool('login', true);
                  logindata.setString('username', username);
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
                child: Text('LogOut')),
          )
        ],
      ),
    );
  }
}

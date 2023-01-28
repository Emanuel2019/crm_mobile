import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'view_data.dart';
import 'package:http/http.dart' as http;

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  String errormgs = "";
  bool error = false;
  bool showprogress = false;
  String name = "";
  String password = "";
  var _name = TextEditingController();
  var _password = TextEditingController();
  starLogin() async {
    String apiurl = "http://localhost/school/login.php";
    print(name);
    var response = await http
        .post(Uri.parse(apiurl), body: {'name': name, 'password': password});
    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false;
          error = true;
          errormgs = jsondata["success"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });
          String id = jsondata["id"];
          String name = jsondata["name"];
          String email = jsondata["email"];
          String phone = jsondata["phone"];
          String city = jsondata["city"];
          String country = jsondata["country"];
          String gender = jsondata["gender"];
        }
      }
    }
  }

  void initState() {
    name = "";
    password = "";
    errormgs = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Iniciar a sessão"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/477290_male.png')),
              ),
            ),
            Container(
              height: 20,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                    hintText: 'Escreva um email válido ex: abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Escreva a password'),
              ),
            ),
            Container(
              height: 30,
            ),
            Container(
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ViewData()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Row(
              children: [
                const Text('Ainda não tenho uma conta ?'),
                TextButton(
                  child: Text(
                    'Se inscrever',
                    style: TextStyle(fontSize: 20, color: Colors.redAccent),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => HomePage())));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}

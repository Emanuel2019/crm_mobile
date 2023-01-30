import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'view_data.dart';
import 'package:crm_mobile/Login.dart';
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
  String apiUrl = "http://localhost/school/login.php";
  String mgsError = "";

  getApi(String email, String password) async {
    final res = await http.post(Uri.parse(apiUrl),
        body: {"email": _email.text, "password": _password.text});
  
    final data = json.decode(res.body);
    if (data['success']!="false") { 
     Navigator.push(context, MaterialPageRoute(builder: (_) => ViewData()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginWidget()));
    }
  }

  var _email = TextEditingController();
  var _password = TextEditingController();

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
                controller: _email,
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
                controller: _password,
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
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => ViewData()));
                  getApi(_email.text, _password.text);
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

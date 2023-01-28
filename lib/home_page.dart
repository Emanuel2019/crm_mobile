import 'package:flutter/material.dart';
import 'package:crm_mobile/model/userModel.dart';
import 'package:crm_mobile/service/userService.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  TextEditingController id = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController country = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  clearRecord() {
    name.text = "";
    email.text = "";
    password.text = "";
    phone.text = "";
    city.text = "";
    country.text = "";
    gender.text = "";
  }

  add(UserModel userModel) async {
    try {
      await userService().addUser(userModel).then((success) {
        Toast.show("Utilizador registado com sucesso",
            duration: Toast.lengthShort, gravity: Toast.center);
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
     ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Registo de utilizador'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nome'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: password,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: phone,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Telefone'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: city,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Cidade'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: country,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'País'),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: gender,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Sexo'),
                  ),
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                       UserModel userModel = UserModel(
                      id: id.text,
                      name: name.text,
                      email: email.text,
                      password: password.text,
                      phone: phone.text,
                      city: city.text,
                      country: country.text,
                      gender: gender.text);
                  add(userModel);
                  
                  clearRecord();
                    },
                    child: Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            )));
  }
}

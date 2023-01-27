import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:crm_mobile/model/userModel.dart';
import 'package:crm_mobile/service/userService.dart';

class AddEditUser extends StatefulWidget {
  final UserModel userModel;
  final int index;
  AddEditUser({required this.userModel, required this.index});
  @override
  State<AddEditUser> createState() => _AddEditUserState();
}

class _AddEditUserState extends State<AddEditUser> {
  TextEditingController id = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController country = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  bool editMode = false;
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
    await userService().addUser(userModel);
  }

  Future<void> InsertRecord() async {
    try {
      String uri = "http://localhost/school/signup.php";
      var res = await http.post(Uri.parse(uri), body: {
        "id": "",
        "name": name.text,
        "email": email.text,
        "password": password.text,
        "phone": phone.text,
        "city": city.text,
        "country": country.text,
        "gender": gender.text
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        Toast.show("Utilizador registado com sucesso",
            duration: Toast.lengthShort);
      } else {
        Toast.show("Utilizador não foi registado com sucesso",
            duration: Toast.lengthShort, backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    if (widget.index != null) {
      name.text = widget.userModel.name;
      email.text = widget.userModel.email;
      password.text = widget.userModel.password;
      phone.text = widget.userModel.phone;
      city.text = widget.userModel.city;
      country.text = widget.userModel.country;
      gender.text = widget.userModel.gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Registar')),
      body: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: name,
          decoration: InputDecoration(
              hintText: 'Escreva o nome do utilizador',
              contentPadding: EdgeInsets.all(10.0)),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(
              hintText: 'Escreva o email do utilizador',
              contentPadding: EdgeInsets.all(10.0)),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Escreva a password do utilizador',
              contentPadding: EdgeInsets.all(10.0)),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: phone,
          decoration: InputDecoration(
              hintText: 'Escreva o telefone do utilizador',
              contentPadding: EdgeInsets.all(10.0)),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: city,
          decoration: InputDecoration(
              hintText: 'Escreva a cidade do utilizador ',
              contentPadding: EdgeInsets.all(10.0)),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: country,
          decoration: InputDecoration(
              hintText: 'Escreva o país do utilizador',
              contentPadding: EdgeInsets.all(10.0)),
        ),
        SizedBox(
          height: 10,
        ),
        DropdownButton<String>(
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.blue),
          items: <String>['Masculino', 'Femenino'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {},
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              if (name.text.isEmpty) {
                Toast.show("O campo não dever estar vázio",
                    duration: Toast.lengthShort);
              } else {
                //InsertRecord();
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
                Toast.show("Utilizador registado com sucesso",
                    duration: Toast.lengthShort);
                clearRecord();
              }
            },
            child: Container(
              height: 50,
              width: 394,
              alignment: Alignment.center,
              child: Text("Gravar"),
            )),
      ]),
    );
  }
}

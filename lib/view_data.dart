import 'package:crm_mobile/home_page.dart';
import 'package:crm_mobile/model/userModel.dart';
import 'package:crm_mobile/service/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'addEditUser.dart';
import 'Login.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late List<UserModel> userlist;
  bool loading = true;
  int index = 0;
  getAllUser() async {
  userlist=  await userService().getUser();
    setState(() {
      loading = false;
    });
    print("User list:${userlist.length}");
  }

  void initState() {
    super.initState();
    getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utilizadores'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
               UserModel user = userlist[index];
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEditUser(userModel: user,index: index,)));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userlist.length,
              itemBuilder: (context, index) {
                UserModel user = userlist[index];
                return ListTile(
                  onTap: () {
                     Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEditUser(userModel: user,index: index,)));
                  },
                  leading: CircleAvatar(child: Text(user.name[0])),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: IconButton(icon: Icon(Icons.delete),onPressed: () {
                    
                  },),
                );
              }),
    );
  }
}

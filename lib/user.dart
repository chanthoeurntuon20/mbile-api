import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}
class _UserState extends State<User> {
  Map listUser;
  List users;
 Future setUser() async{
   String url = "https://reqres.in/api/users";
   http.Response response = await http.get(url);//store object
  listUser = json.decode(response.body);
  setState(() {
    users = listUser["data"];//Map only data ; data is array
  });
 }
 @override
void initState() {
    super.initState();
    setUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("User Information"),
      ),
      body: ListView.builder(
        itemCount: users == null ? 0: users.length,
        itemBuilder: (context, i){
          final user = users[i];
         return Container( 
           margin: EdgeInsets.all(20),
          child : Row( 
             children: <Widget>[
               CircleAvatar(
                 backgroundImage: NetworkImage("${user["avatar"]}"),
               ),
               Card(
             margin: EdgeInsets.all(20),
            child : Text("${user["first_name"]}"),
         )
             ],
             
           )
         );
        },
      ),
    );
  }
}
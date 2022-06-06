import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasi/Models/Pasien.dart';
import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Obat.dart';
import '../../Models/Resep.dart';
import '../../service/Auth.dart';
import '../../service/Services.dart';

class PasienList extends StatefulWidget {
  const PasienList({Key? key}) : super(key: key);

  @override
  State<PasienList> createState() => _PasienListState();
}

class _PasienListState extends State<PasienList> {
  @override
  List<Pasien> result = [];
  List<Pasien> pasien = [];
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Daftar Pasien');
  final AuthService _auth = AuthService();
  onSearch(String query) {
    setState(() {
      result= pasien.where((user) => user.nama.toLowerCase().contains(query)).toList();
      print(result);
    });
  }
  @override
  Widget build(BuildContext context) {
    pasien  = Provider.of<List<Pasien>>(context);
    if(result.isEmpty){
      result=pasien;
    }
    return Scaffold(
        backgroundColor: Color.fromRGBO(250, 248, 246, 1),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Daftar Pasien"),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.orangeAccent,
              ),
              label: Text(
                "Logout",
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value)=>onSearch(value),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Masukan Nama Pasien Untuk Mencari",
                    hintStyle:
                        TextStyle(fontSize: 14.0, color: Colors.grey.shade500)),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: ListView.builder(
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          tileColor: Colors.blue[200],
                          leading: CircleAvatar(
                            child: Text(result[index].nama[0],style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.grey[800],
                          ),
                          title: Text(result[index].nama),
                          subtitle: Text(
                              result[index].id + " " + result[index].gender),
                          onTap: () {
                            Navigator.pushNamed(context, '/ProfileProvider',arguments: {
                              'uid':result[index].uid
                            });
                          },
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}

import 'package:farmasi/Models/Resep.dart';
import 'package:farmasi/Models/User.dart';
import 'package:farmasi/service/Database.dart';
import 'package:farmasi/service/Services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Obat.dart';
import '../../Models/Pasien.dart';
import '../../service/Auth.dart';

class HomePasien extends StatefulWidget {
  HomePasien({Key? key}) : super(key: key);
  MyUser pasien = MyUser(uid: "");

  HomePasien.Pasien({pasien}) {
    this.pasien = pasien;
  }

  @override
  State<HomePasien> createState() => _HomePasienState();
}

class _HomePasienState extends State<HomePasien> {
  final AuthService _auth = AuthService();
  String avatar = "A";
  @override
  Widget build(BuildContext context) {
    final pasien = Provider.of<Pasien>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 248, 246, 1),
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text("Minum Obat - Pasien"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextButton.icon(
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
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: (Padding(
          padding: EdgeInsets.all(20.0),
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                child: Image(image: AssetImage('assets/avatar.png'),),
                radius: 50,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  "Nama     :",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ), SizedBox(width: 20.0,),
                Text(pasien.nama,style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),)
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  "ID            :",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ), SizedBox(width: 20.0,),
                Text(pasien.id,style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),)
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text(
                  "Usia        :",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ), SizedBox(width: 20.0,),
                Text(pasien.tahun_lahir.toString(),style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),)
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text(
                  "Jenis Kelamin   :",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ), SizedBox(width: 20.0,),
                Text(pasien.gender,style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black
                ),)
              ],
            ),

          ],
        ),
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/JadwalProvider',
              arguments: {'uid': pasien.uid, 'pasien': pasien});
        },
        label: const Text('Jadwal Minum Obat',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
        icon: const Icon(Icons.calendar_today,color: Colors.white),
        backgroundColor: Colors.orangeAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

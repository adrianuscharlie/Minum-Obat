import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Obat.dart';
import '../../Models/Pasien.dart';
import '../../Models/Resep.dart';
import '../shared/Loading.dart';

class ProfilePasien extends StatefulWidget {
  const ProfilePasien({Key? key}) : super(key: key);

  @override
  State<ProfilePasien> createState() => _ProfilePasienState();
}

class _ProfilePasienState extends State<ProfilePasien> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    final Pasien pasien = Provider.of<Pasien>(context);
    final List<Resep> resep = Provider.of<List<Resep>>(context);
    List<Obat> obat = Provider.of<List<Obat>>(context);
    pasien.resep_obj = resep;
    return StreamBuilder(
      stream: DatabaseServices(uid: pasien.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(250, 248, 246, 1),
            appBar: AppBar(
              backgroundColor: Colors.blue[600],
              title: Text("Profile Pasien"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: (Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        child: Text(
                          pasien.nama[0],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        radius: 50,
                        backgroundColor: Colors.grey[800],
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
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            pasien.nama,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        )
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
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          pasien.id,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        )
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
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          pasien.tahun_lahir.toString(),
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        )
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
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          pasien.gender,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text(
                          "Resep     :",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          resep.length.toString() + " Resep",
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/InputObat',
                            arguments: {'pasien': pasien, 'obat': obat});
                      },
                      child: Text(
                        "Buat Resep Obat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

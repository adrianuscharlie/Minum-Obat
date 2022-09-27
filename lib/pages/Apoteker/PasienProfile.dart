import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
              padding: EdgeInsets.fromLTRB(30, 50, 20, 20),
              scrollDirection: Axis.vertical,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Image(image: AssetImage('assets/avatar.png')),
                      radius: 50.0,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("Nama",
                        style: GoogleFonts.ubuntu(
                            fontSize: 20.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20.0,
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        pasien.nama,
                        style: GoogleFonts.ubuntu(
                            fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Nomor RM",
                      style: GoogleFonts.ubuntu(
                          fontSize: 20.0,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        pasien.id,
                        style: GoogleFonts.ubuntu(
                            fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Usia",
                      style: GoogleFonts.ubuntu(
                          fontSize: 20.0,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        pasien.tahun_lahir.toString(),
                        style: GoogleFonts.ubuntu(
                            fontSize: 20.0, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Jenis Kelamin",
                      style: GoogleFonts.ubuntu(
                          fontSize: 20.0,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        pasien.gender,
                        style: GoogleFonts.ubuntu(
                            fontSize: 20.0, color: Colors.black),
                      ),
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
                  ]),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

import 'package:farmasi/Models/Resep.dart';
import 'package:farmasi/Models/User.dart';
import 'package:farmasi/service/Database.dart';
import 'package:farmasi/service/Services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: FittedBox(
          child: Text(
            "Minum Obat - Pasien",
            style:
                GoogleFonts.ubuntu(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          fit: BoxFit.fitWidth,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.orangeAccent,
              ),
              label: Text(
                "Logout",
                style: GoogleFonts.ubuntu(color: Colors.orangeAccent),
              ),
            ),
          )
        ],
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
                  style:
                      GoogleFonts.ubuntu(fontSize: 20.0, color: Colors.black),
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
                  style:
                      GoogleFonts.ubuntu(fontSize: 20.0, color: Colors.black),
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
                  style:
                      GoogleFonts.ubuntu(fontSize: 20.0, color: Colors.black),
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
                  style:
                      GoogleFonts.ubuntu(fontSize: 20.0, color: Colors.black),
                ),
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/JadwalProvider',
              arguments: {'uid': pasien.uid, 'pasien': pasien});
        },
        label: const Text(
          'Jadwal Minum Obat',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        icon: const Icon(Icons.calendar_today, color: Colors.white),
        backgroundColor: Colors.orangeAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

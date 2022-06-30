import 'package:farmasi/pages/Pasien/ListViewJadwal.dart';
import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Jadwal.dart';
import '../../Models/Pasien.dart';
import '../../Models/Resep.dart';
import '../../service/Services.dart';
import '/Models/Obat.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({Key? key}) : super(key: key);

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context)!.settings.arguments as Map;
    Pasien pasien=data['pasien'];
    final jadwal=Provider.of<List<Jadwal>>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 248, 246, 1),
      appBar: AppBar(
        title: Text("Jadwal Minum Obat"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ Expanded(
          child: jadwal.isNotEmpty&& jadwal.isNotEmpty?ListJadwal.Pasien(jadwal:jadwal,pasien: pasien,):Container(
                  child: Center(child: Text("Belum Ada Resep/Obat \nYang Harus Diminum",style: TextStyle(color: Colors.grey[800],fontSize: 20),)),
            ),
          ),
     ] ),
    );
  }
}

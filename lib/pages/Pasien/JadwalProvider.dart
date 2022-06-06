import 'package:farmasi/pages/Pasien/Jadwal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Jadwal.dart';
import '../../Models/Obat.dart';
import '../../Models/Pasien.dart';
import '../../Models/Resep.dart';
import '../../service/Database.dart';
import '../Apoteker/PasienList.dart';

class JadwalProvider extends StatefulWidget {
  const JadwalProvider({Key? key}) : super(key: key);

  @override
  State<JadwalProvider> createState() => _JadwalProviderState();
}

class _JadwalProviderState extends State<JadwalProvider> {
  @override
  Widget build(BuildContext context) {
    Map data=ModalRoute.of(context)!.settings.arguments as Map;
    String uid=data['uid'];
    return MultiProvider(
        providers: [
          StreamProvider<List<Obat>>.value(
            value: DatabaseServices(uid: uid).obat_list,
            initialData: [],
          ),
          StreamProvider<List<Resep>>.value(
            value: DatabaseServices(uid: uid).resep_list,
            initialData: [],
          ),
          StreamProvider<Pasien>.value(
            value: DatabaseServices(uid: uid).userData,
            initialData: Pasien(uid: uid),
          ),
        StreamProvider<List<Jadwal>>.value(
          value: DatabaseServices(uid: uid).jadwal_list,
          initialData: [],
        ),],
        child:JadwalScreen()
    );
  }
}

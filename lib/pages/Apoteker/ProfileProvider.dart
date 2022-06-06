import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasi/pages/Apoteker/PasienList.dart';
import 'package:farmasi/pages/Apoteker/PasienProfile.dart';
import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Obat.dart';
import '../../Models/Resep.dart';
import '../../Models/User.dart';
import '/Models/Pasien.dart';

class ProfileProvider extends StatefulWidget {
   const ProfileProvider({Key? key}) : super(key: key);

  @override
  State<ProfileProvider> createState() => _ProfileProviderState();
}

class _ProfileProviderState extends State<ProfileProvider> {
  Map data={};
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context)!.settings.arguments as Map;
    String uid=data['uid']??'';
    return MultiProvider(
        providers: [
          StreamProvider<List<Pasien>>.value(
            value: DatabaseServices(uid: uid).pasien_list,
            initialData: [],
          ),
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
          )],
        child:ProfilePasien()
    );
  }
}

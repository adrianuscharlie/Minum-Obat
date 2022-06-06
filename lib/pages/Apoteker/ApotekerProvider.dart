import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasi/pages/Apoteker/PasienList.dart';
import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Obat.dart';
import '../../Models/Resep.dart';
import '../../Models/User.dart';
import '/Models/Pasien.dart';

class ApotekerProvider extends StatefulWidget {
   ApotekerProvider({Key? key}) : super(key: key);
  MyUser apoteker=MyUser(uid: "");
  ApotekerProvider.Apoteker({apoteker}){
    this.apoteker=apoteker;
  }
  @override
  State<ApotekerProvider> createState() => _PasienState();
}

class _PasienState extends State<ApotekerProvider> {
  @override
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Daftar Pasien');

  Widget build(BuildContext context) {
    String uid=widget.apoteker.uid;
    return StreamProvider<List<Pasien>>.value(
      value: DatabaseServices(uid: uid).pasien_list,
      initialData: [],
      child: PasienList(),
    );
  }
}







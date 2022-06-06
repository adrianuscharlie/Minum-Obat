import 'package:farmasi/Models/Resep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Obat.dart';
import '../../Models/Pasien.dart';
import '../../Models/User.dart';
import '../../service/Database.dart';
import 'HomePasien.dart';


class HomeProvider extends StatefulWidget {
  HomeProvider({Key? key}) : super(key: key);
  MyUser pasien = MyUser(uid: "");

  HomeProvider.Pasien({pasien}){
    this.pasien = pasien;
  }

  @override
  State<HomeProvider> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  @override
  Widget build(BuildContext context) {
    MyUser pasien = widget.pasien;
    return StreamProvider<Pasien>.value(
      value: DatabaseServices(uid: pasien.uid).userData,
      initialData: Pasien(uid: pasien.uid),
      child: HomePasien.Pasien(pasien: pasien),
    );
  }
}

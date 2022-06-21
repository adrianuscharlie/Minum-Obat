import 'package:farmasi/pages/Apoteker/Input_Obat.dart';
import 'package:farmasi/pages/Apoteker/ApotekerProvider.dart';
import 'package:farmasi/pages/Pasien/HomePasien.dart';
import 'package:farmasi/Models/User.dart';
import 'package:farmasi/pages/Pasien/HomePasien.dart';
import 'package:farmasi/pages/Pasien/HomeProvider.dart';
import 'package:farmasi/pages/shared/Authenticate.dart';
import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Pasien.dart';
import 'Login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> uid_apoteker=["JRUfFfnniEOe4oOghfyeWVqY1Lh1"];
    final user=Provider.of<MyUser?>(context);
    if(user==null){
      return Authenticate();
    }else{
      if(uid_apoteker.contains(user.uid)){
        return ApotekerProvider.Apoteker(apoteker: user);
      }else{
        return HomeProvider.Pasien(pasien:user);
      }
    }
  }
}



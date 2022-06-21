import 'Obat.dart';
import '../Models/Obat.dart';
import 'Resep.dart';

class Pasien {
  String nama = "";
  String id = "";
  String gender = "";
  List<String> resep = [];
  String uid = "";
  List<Resep> resep_obj=[];
  int usia=0;
  String token="";

  Pasien({uid}) {
    this.uid=uid;
  }

  Pasien.Complete({nama,id,gender,usia,token}) {
    this.nama = nama;
    this.id = id;
    this.gender = gender;
    this.usia=usia;
    this.token=token;
  }

  factory Pasien.fromJson(dynamic json,uid) {
    Pasien pasien = Pasien.Complete(
      nama: json['nama'] as String,
      id: json['id'] as String,
      gender: json['gender'] as String,
      usia: json['usia'] as int,
      token: json['token']as String

    );
    pasien.uid=uid;
    return pasien;
  }

  List<Obat> convertObat(List<String> id_obat, List<Obat> obat) {
    List<Obat> convert = [];
    for (int i = 0; i < obat.length; i++) {
      if (id_obat[i] == obat[i].id) {
        convert.add(obat[i]);
      }
    }
    return convert;
  }
}

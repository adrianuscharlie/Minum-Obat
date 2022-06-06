import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Obat.dart';

class Resep{
  String id="";
  String id_obat="";
  int dosis=2;
  int jam_konsumsi=10;
  int jeda_konsumsi=6;
  DateTime tanggal_mulai=DateTime.now();
  DateTime tanggal_selesai=DateTime.now();
  Obat obat=Obat(id: '',nama: '',desc: '');

  Resep({id,id_obat,jam_konsumsi,jeda_konsumsi,dosis}){
    this.id=id;
    this.id_obat=id_obat;
    this.jam_konsumsi=jam_konsumsi;
    this.jeda_konsumsi=jeda_konsumsi;
    this.dosis=dosis;
}
  factory Resep.fromJson(dynamic json,id) {
    Resep resep = Resep(
      id: id,
      dosis: json['dosis'],
      id_obat: json['id_obat'],
      jam_konsumsi: json['jam_konsumsi'] ,
      jeda_konsumsi: json['jeda_konsumsi'],
    );
    Timestamp mulai=json['tanggal_mulai'];
    Timestamp selesai=json['tanggal_selesai'];
    resep.tanggal_mulai=mulai.toDate();
    resep.tanggal_selesai=selesai.toDate();
    return resep;
  }

}
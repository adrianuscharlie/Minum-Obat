import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasi/Models/Obat.dart';
import 'package:farmasi/Models/Resep.dart';
import 'package:farmasi/Models/User.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/Jadwal.dart';
import '../Models/Pasien.dart';
import '../pages/Pasien/Jadwal.dart';
import 'package:http/http.dart' as http;

class DatabaseServices {
  final CollectionReference pasien =
  FirebaseFirestore.instance.collection('pasien');
  final CollectionReference obat =
  FirebaseFirestore.instance.collection('obat');
  final CollectionReference apoteker =
  FirebaseFirestore.instance.collection('apoteker');
  String uid = "";
  final CollectionReference jadwal=FirebaseFirestore.instance.collection('jadwal');

  DatabaseServices({uid}) {
    this.uid = uid;
  }

  storeNotificationToken(uid)async{
    String? token=await FirebaseMessaging.instance.getToken();
    pasien.doc(uid).update({
      'token':token
    });
  }

  List<Pasien> pasienListFromSnapshot(QuerySnapshot snapshot) {
    var data = snapshot.docs as List<dynamic>;
    List<Pasien> pasien = [];
    data.forEach((element) {
      String uid = element.id;
      Pasien pas = Pasien.fromJson(element, uid);
      pasien.add(pas);
    });
<<<<<<< HEAD
    pasien.sort((a, b) => a.nama.compareTo(b.nama));
=======
>>>>>>> 212101cebf3ef03d9aef4f935e6e97784c956e64
    return pasien;
  }

  Stream<Pasien> get userData {
    return pasien.doc(uid).snapshots().map(_PasienData);
  }

  Pasien _PasienData(DocumentSnapshot snapshot) {
    Pasien pasien = Pasien.fromJson(snapshot.data(), uid);
    return pasien;
  }

  List<Resep> resepListFromSnapshot(QuerySnapshot snapshot) {
    var data = snapshot.docs as List<dynamic>;
    List<Resep> resep = [];
    data.forEach((element) {
      String id = element.id;
      Resep pas = Resep.fromJson(element, id);
      resep.add(pas);
    });
    return resep;
  }
  List<Jadwal> jadwalListFromSnapshot(QuerySnapshot snapshot) {
    var data = snapshot.docs as List<dynamic>;
    List<Jadwal> jadwal = [];
    data.forEach((element) {
      String id = element.id;
      Jadwal pas = Jadwal.fromJson(element, id);
      if(pas.jadwal.isBefore(DateTime.now())){
        if(DateTime.now().isBefore(pas.jadwal.add(Duration(hours: 2)))){
            jadwal.add(pas);  
        }
 
      }
    });
    return jadwal;
  }


  List<Obat> obatListFromSnapshot(QuerySnapshot snapshot) {
    var data = snapshot.docs as List<dynamic>;
    List<Obat> obat = [];
    data.forEach((element) {
      String id = element.id;
      Obat bat = Obat.fromJson(element, id);
      obat.add(bat);
    });
    obat.sort((a, b) => a.nama.compareTo(b.nama));
    return obat;
  }

  Stream<List<Pasien>> get pasien_list {
    return pasien.snapshots().map(pasienListFromSnapshot);
  }

  Stream<List<Obat>> get obat_list {
    return obat.snapshots().map(obatListFromSnapshot);
  }

  Stream<List<Resep>> get resep_list {
    CollectionReference resep = pasien.doc(uid).collection('resep');
    return resep.snapshots().map(resepListFromSnapshot);
  }
  Stream<List<Jadwal>> get jadwal_list{
    CollectionReference jadwal = pasien.doc(uid).collection('jadwal');
    return jadwal.snapshots().map(jadwalListFromSnapshot);
  }


  Future sendRecord(Pasien pasien, Jadwal jadwal) async {
    DateTime now = DateTime.now();
    String format = DateFormat('dd_MM_yyy_kk:mm').format(now);
    bool status=now.compareTo(jadwal.jadwal.add(Duration(hours: 1)))>0;
    return await this
        .pasien
        .doc(pasien.uid)
        .collection('record')
        .doc(jadwal.id + '_' + format)
        .set({
      'nama_obat': jadwal.nama_obat,
      'jam_konsumsi': Timestamp.now(),
      'nama': pasien.nama,
      'jadwal_konsumsi':Timestamp.fromDate(jadwal.jadwal),
      'telat':status
    });
  }
  Future deleteJadwal(Pasien pasien,String id_jadwal) async{
    return await this
        .pasien.doc(pasien.uid)
        .collection('jadwal')
        .doc(id_jadwal)
        .delete();
  }

  Future addPasien(String uid, String nama, String id, String gender) async {
    return await pasien.doc(uid).set({
      'nama': nama,
      'gender': gender,
      'id': id,
    });
  }

  Future addResep(Pasien pasien, String id_obat, TimeOfDay jam, int dosis, int jeda, Timestamp start, Timestamp end) async {
    int temp = pasien.resep_obj.length + 1;
    return await this
        .pasien
        .doc(pasien.uid)
        .collection('resep')
        .doc('resep_' + (temp.toString()))
        .set({
      'dosis': dosis,
      'id_obat': id_obat,
      'jam_konsumsi': jam.hour,
      'jeda_konsumsi': jeda,
      'tanggal_mulai': start,
      'tanggal_selesai': end,
      'menit_konsumsi': jam.minute
    });
  }

  Future addJadwal(String format, Pasien pasien, String nama_obat, String desc, int jam,int menit,DateTime jadwal) async {
    DateTime time=DateTime(jadwal.year,jadwal.month,jadwal.day,jam,menit);
    Timestamp stamp=Timestamp.fromDate(time);
    return await this.pasien.doc(pasien.uid).collection('jadwal')
        .doc(format)
        .set({
      'nama_obat': nama_obat,
      'waktu_minum':stamp,
      'desc':desc,
    });
  }
  Future createNotification(Pasien pasien,String nama_obat,int jam,int menit,DateTime jadwal) async{
    DateTime time=DateTime(jadwal.year,jadwal.month,jadwal.day,jam,menit);
    Timestamp stamp=Timestamp.fromDate(time);
    return await this.jadwal.doc()
        .set({
      'nama':pasien.nama,
      'jadwal':stamp,
      'obat':nama_obat,
      'status':false,
      'token':pasien.token
    });
  }

}

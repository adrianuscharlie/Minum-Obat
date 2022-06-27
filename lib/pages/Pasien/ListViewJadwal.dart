import 'package:flutter/material.dart';

import '../../Models/Jadwal.dart';
import '../../Models/Obat.dart';
import '../../Models/Pasien.dart';
import '../../Models/Resep.dart';
import '../../service/Database.dart';

class ListJadwal extends StatefulWidget {
  ListJadwal({Key? key}) : super(key: key);
  List<Jadwal> jadwal=[];
  Pasien pasien = Pasien(uid: "");

  ListJadwal.Pasien({jadwal,pasien}) {
    this.jadwal=jadwal;
    this.pasien = pasien;
  }

  @override
  State<ListJadwal> createState() => _ListJadwalState();
}

class _ListJadwalState extends State<ListJadwal> {
  @override
  Widget build(BuildContext context) {
    List<Jadwal> jadwal = widget.jadwal;
    Pasien pasien = widget.pasien;
    return Container(
        padding: EdgeInsets.all(3.0),
        child: ListView.builder(
            itemCount: jadwal.length,
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                    child: ListTile(
                  tileColor: Colors.lightBlueAccent,
                  title: Text(
                    jadwal[index].nama_obat,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        jadwal[index].desc_obat,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      //Text("Tanggal Mulai :"+Services().jadwalPasien(resep[index].tanggal_mulai)),
                      //Text("Tanggal Selesai : "+Services().jadwalPasien(resep[index].tanggal_selesai)),
                      Text("Jadwal Konsumsi : " +
                            jadwal[index].formattedDate,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          setState(() {
                            DatabaseServices(uid: pasien.uid)
                                .sendRecord(pasien, jadwal[index]);
                            DatabaseServices(uid: pasien.uid).deleteJadwal(pasien, jadwal[index].id);
                            jadwal.removeAt(index);
                          });
                        },
                        child: Text("Sudah Minum"),
                      )
                    ],
                  ),
                )),
              );
            }));
  }
}

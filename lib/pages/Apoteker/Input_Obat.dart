import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasi/service/Database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../Models/Pasien.dart';
import '../../service/Services.dart';
import '/Models/Obat.dart';

class Input_Obat extends StatefulWidget {
  const Input_Obat({Key? key}) : super(key: key);

  @override
  State<Input_Obat> createState() => _Input_ObatState();
}

class _Input_ObatState extends State<Input_Obat> {
  List<String> dropdownValue=["1","2","3","4","5","6","7","8","9","10","11","12"];
  Map data={};
  DateTime startDate = DateTime.now();
  DateTime endDate=DateTime.now();
  List <Obat> obat=[];
  List <String> nama_obat=["Nama Obat"];
  String obat_onchange="Nama Obat";
  int jam=10;
  int dosis=2;
  int jeda=2;
  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }
  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }
  TimeOfDay selectedTime = TimeOfDay.now();
  TimePicker(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    String  formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime);
    data=ModalRoute.of(context)!.settings.arguments as Map;
    obat=data['obat'];
    Pasien pasien=data['pasien'];
    this.obat.forEach((element) {
      if(!nama_obat.contains(element.nama)){
        this.nama_obat.add(element.nama);
      }
    });
    setState(() {
    });
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 248, 246, 1),
      appBar: AppBar(
        title: Text("Input Obat Pasien"),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama Obat",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(5),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2.0, color: Colors.orange),
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButton<String>(
                  value: this.obat_onchange,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, size: 22,color: Colors.black,),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  focusColor: Color.fromRGBO(250, 248, 246, 1),
                  dropdownColor: Color.fromRGBO(250, 248, 246, 1),
                  hint: Text("Jeda Konsumsi Obat"),
                  underline: SizedBox(),
                  items: nama_obat.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                        obat_onchange=value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Jeda Konsumsi obat (Jam)",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(5),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2.0, color: Colors.orange),
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButton<String>(
                  value: this.jeda.toString(),
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, size: 22,color: Colors.black,),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  focusColor: Color.fromRGBO(250, 248, 246, 1),
                  dropdownColor: Color.fromRGBO(250, 248, 246, 1),
                  hint: Text("Jeda Konsumsi Obat"),
                  underline: SizedBox(),
                  items: dropdownValue.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    //Do something with this value
                    setState(() {
                      jeda = int.parse(value!);
                    });
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Text("Dosis/Hari",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(5),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2.0, color: Colors.orange),
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButton<String>(
                  value: this.dosis.toString(),
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, size: 22,color: Colors.black,),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  focusColor: Color.fromRGBO(250, 248, 246, 1),
                  dropdownColor: Color.fromRGBO(250, 248, 246, 1),
                  hint: Text("Jeda Konsumsi Obat"),
                  underline: SizedBox(),
                  items: dropdownValue.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    //Do something with this value
                    setState(() {
                      dosis = int.parse(value!);
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Jam Mulai Konsumsi",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RaisedButton(
                    onPressed: () => TimePicker(context),
                    child: Text('Pilih Jam'),
                  ),
                  SizedBox(width: 20.0),
                  Text(formattedTimeOfDay,style: TextStyle(color: Colors.black),),
                ],
              ),
              SizedBox(height: 20.0,),
              SizedBox(
                height: 20.0,
              ),
              Text("Tanggal Mulai Konsumsi Obat",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RaisedButton(
                    onPressed: () => _startDate(context),
                    child: Text('Select date'),
                  ),
                  SizedBox(width: 20.0),
                  Text(DateFormat('dd-MM-yyyy').format(startDate),style: TextStyle(color: Colors.black,fontSize: 15),),
                ],
              ),
              SizedBox(height: 20.0,),
              Text("Tanggal Berhenti Konsumsi Obat",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RaisedButton(
                    onPressed: () => _endDate(context),
                    child: Text('Select date'),
                  ),
                  SizedBox(width: 20.0),
                  Text(DateFormat('dd-MM-yyyy').format(endDate),style: TextStyle(color: Colors.black,fontSize: 15)),
                ],
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                  ),
                   child: Text("Buat Resep", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0
                ),),
                  onPressed: () async{
                    setState(() {
                      Timestamp mulai = Timestamp.fromDate(startDate);
                      Timestamp selesai = Timestamp.fromDate(endDate);
                      dynamic resep=DatabaseServices(uid: pasien.uid).addResep(pasien, Services().getObat(obat_onchange, obat).id, selectedTime, dosis, jeda, mulai, selesai);
                      Duration duration = endDate.difference(startDate);
                      int dur = duration.inDays;
                      print(dur);
                      if(dur==0 && duration.inSeconds>1){
                        dur=1;
                      }
                      for (int i = 0; i < dur; i++) {
                        int jam=selectedTime.hour;
                        int menit=selectedTime.minute;
                        for (int j = 0; j < dosis; j++) {
                          if(j!=0){
                            jam+=jeda;
                          }
                          String format_jadwal = 'resep_' + (pasien.resep_obj.length + 1).toString() + '_' + obat_onchange +
                              "_" + i.toString() + "_" + j.toString();
                          dynamic result =DatabaseServices(uid: pasien.uid).addJadwal(format_jadwal, pasien, obat_onchange,Services().getObat(obat_onchange, obat).desc,jam,menit,startDate);
                          dynamic hasil=DatabaseServices(uid: pasien.uid).createNotification(pasien, obat_onchange, jam,menit,startDate);
                        }
                        startDate=startDate.add(Duration(days: 1));
                      }
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    });
                  },

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

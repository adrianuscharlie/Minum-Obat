import 'package:flutter/material.dart';

import '../../service/Auth.dart';

class RegisterPasien extends StatefulWidget {
  const RegisterPasien({Key? key}) : super(key: key);

  @override
  State<RegisterPasien> createState() => _RegisterPasienState();
}

class _RegisterPasienState extends State<RegisterPasien> {
  final _formKey = new GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _idController=TextEditingController();
  var rememberValue = false;
  final AuthService _auth = AuthService();
  bool loading = false;
  String name = "";
  String email = "";
  String password = "";
  String error = "";
  String gender = "Laki-Laki";
  List<String> gender_list = ["Laki-Laki", "Perempuan"];
  String id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 248, 246, 1),
      appBar: AppBar(
        title: Text("Daftar Akun Pasien"),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _nameController,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukan Nama Anda";
                        }
                      },
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                          label: Text(
                            "Nama Pasien",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Masukan Nama Anda",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          prefixIcon: Icon(
                            Icons.emoji_people,
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.orangeAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(5))),
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      controller: _idController,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Masukan ID Anda";
                        }
                      },
                      decoration: InputDecoration(
                          label: Text("ID Pasien",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Masukan ID Anda",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          prefixIcon: Icon(
                            Icons.perm_identity,
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.orangeAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(5))),
                      onChanged: (val) {
                        setState(() => id = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Jenis Kelamin :",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 2.0, color: Colors.orange),
                                borderRadius: BorderRadius.circular(5.0))),
                        child: DropdownButton<String>(
                          value: this.gender,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          focusColor: Color.fromRGBO(250, 248, 246, 1),
                          dropdownColor: Color.fromRGBO(250, 248, 246, 1),
                          isExpanded: true,
                          hint: Text("Pilih Jenis Kelamin"),
                          icon: Icon(Icons.keyboard_arrow_down, size: 22),
                          underline: SizedBox(),
                          items: gender_list.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      controller: _emailController,
                      maxLines: 1,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "Please entry your email";
                        }
                      },
                      decoration: InputDecoration(
                          label: Text(
                            "Email",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Masukan Email Anda",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          prefixIcon: Icon(
                            Icons.perm_identity,
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.orangeAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(5))),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      controller: _passwordController,
                      maxLines: 1,
                      obscureText: true,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Masukan password dengan ketentuan minimal 6 karakter";
                        }
                      },
                      decoration: InputDecoration(
                          label: Text(
                            "Password",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Masukan Password Anda",
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.orangeAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(5))),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              dynamic result =
                                  await _auth.registerWithEmailandPassword(
                                      email, password, name, id, gender);
                              setState(() {
                                Navigator.pop(context);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orangeAccent,
                            padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                            
                          ),
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:farmasi/service/Auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'Loading.dart';

class LoginApoteker extends StatefulWidget {
  final Function toggleView;
  LoginApoteker({ required this.toggleView });

  @override
  State<LoginApoteker> createState() => _LoginApotekerState();
}

class _LoginApotekerState extends State<LoginApoteker> {
  final _formKey = new GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController=TextEditingController();
  var rememberValue = false;
  final AuthService _auth=AuthService();
  bool loading=false;
  String email="";
  String password="";
  String error="";
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.blue[600],
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Sign In Apoteker",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0
              ),),
            SizedBox(
              height: 60.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    maxLines: 1,
                    validator: (value){
                      if(value!.isEmpty || !value.contains("@")){
                        return "Please entry your email";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Masukan Username",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                    onChanged: (val){
                      setState(()=>email=val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    maxLines: 1,
                    obscureText: true,
                    validator: (value){
                      if(value!.length<6){
                        return "Masukan password dengan ketentuan minimal 6 karakter";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Masukan Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                    onChanged: (val){
                      setState(()=>password=val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    child: Text("Login Sebagai Pasien? Klik Disini",style: TextStyle(
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold
                    ),),
                    onTap: (){
                      widget.toggleView();
                    },
                  ),
                  SizedBox(height: 20.0,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                      padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(20, 10, 20, 10)),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState!.validate()){
                        dynamic result=await _auth.signInWithEmailandPassword(email, password);
                        if(result!=null){
                          setState((){
                            loading=true;
                          });
                        }else{
                          print("Lolos");
                          _emailController.clear();
                          _passwordController.clear();
                        }
                      }
                    }, child: Text("Masuk", style: TextStyle(
                    //fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: 'Montserrat'
                  ),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

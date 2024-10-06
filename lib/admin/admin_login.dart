
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/admin/admin_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
              padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:  BoxDecoration(
                gradient: const LinearGradient(colors: [Color.fromARGB(255, 53, 51, 51),Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(MediaQuery.of(context).size.width, 110),
                )
              ),
              
            ),
            SingleChildScrollView(
              child: Container( 
                margin: const EdgeInsets.only(left: 30,right: 30,top: 60),
                child: Form(
                  key: _formkey, 
                  child: Column(
                    children: [
                      const Text("Let's start with\n\t\t\t\t\t\t\tAdmin!",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 30,),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: MediaQuery.of(context).size.height/2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Container(
                                padding: const EdgeInsets.only(left: 20, top:4,bottom: 5),
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color:const Color.fromARGB(255,160,160, 147)),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Username",
                                      hintStyle: TextStyle(color:Color.fromARGB(255, 160, 160, 147) ),
                                      ),
                                    controller: usernamecontroller,
                                    validator: (value){
                                      if(value==null || value.isEmpty){
                                        return "Please enter Username";
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Container(
                                padding: const EdgeInsets.only(left: 20, top:4,bottom: 5),
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color:const Color.fromARGB(255,160,160, 147)),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      
                                      border: InputBorder.none,
                                       hintText: "Password",
                                      hintStyle: TextStyle(color:Color.fromARGB(255, 160, 160, 147) ),
                                      ),
                                    controller: userpasswordcontroller,
                                    validator: (value){
                                      if(value==null || value.isEmpty){
                                        return "Please enter Password";
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              GestureDetector(
                                onTap: (){
                                  LoginAdmin();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: const Center(
                                    child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),), 
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
// ignore: non_constant_identifier_names
LoginAdmin(){
  FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
    snapshot.docs.forEach((result){
      if(result.data()["id"]!=usernamecontroller.text.trim()){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Invalid Username")));
      }
      else if(result.data()["password"]!=userpasswordcontroller.text.trim()){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Invalid Password")));
      }else{
        Route route = MaterialPageRoute(builder: (context)=>const AdminHome());
        Navigator.pushReplacement(context, route);
      }
    });
  });
}

}
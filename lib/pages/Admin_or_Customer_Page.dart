import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/admin/admin_login.dart';
import 'package:sign_in/pages/bottomnav.dart';
import 'package:sign_in/pages/forgot_password.dart';
import 'package:sign_in/pages/onboard.dart';
import 'package:sign_in/pages/signup.dart';
import 'package:sign_in/widgets/wigdets%20_support.dart';

class AdminCustomer extends StatefulWidget {
  @override
  State<AdminCustomer> createState() => _AdminCustomerState();
}

class _AdminCustomerState extends State<AdminCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffff5c30),
                      Color(0xffe74b1a),
                      Colors.yellow
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 55,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "images/logo.png",
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              maxLines: 2,
                              "Are You Admin \n  or Customer?",
                              style: AppWidget.HeadlineTextFieldStyle(),
                            ),
                            SizedBox(height: 40,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffff5722),
                                          borderRadius: BorderRadius.circular(15)),
                                      child: const Center(
                                        child: Text(
                                          "Customer",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        const Color(0xffff5c30),
                                        const Color(0xffe74b1a),
                                        Colors.yellow
                                      ]),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Divider(
                                    color: Colors.transparent,
                                    thickness: 5,
                                  ),
                                ),    
                                const SizedBox(
                                  height: 20,
                                ),               
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminLogin()));
                                  },
                                  child: Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffff5722),
                                          borderRadius: BorderRadius.circular(15)),
                                      child: const Center(
                                        child: Text(
                                          "Admin",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
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

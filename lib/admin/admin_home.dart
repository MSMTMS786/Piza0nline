
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sign_in/admin/add_food.dart';
import 'package:sign_in/admin/admin_login.dart';
import 'package:sign_in/pages/bottomnav.dart';
import 'package:sign_in/widgets/wigdets%20_support.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        margin: EdgeInsets.only(top:40,left: 15,right: 15),
        child: Column(
          children: [
            Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("Home Admin",style: AppWidget.HeadlineTextFieldStyle(),),
              IconButton(
                color: Colors.white,
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
                },
                icon: Icon(Icons.logout,color: Colors.black,),)

              ],),),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFood()));
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black ,
                      borderRadius: BorderRadius.circular(10)
                     ),
                     child: Row(
                      children: [
                        Padding(padding: EdgeInsets.all(6)),
                        Image.asset("images/food.jpg",height: 100,width: 100,fit:BoxFit.cover ,),
                        SizedBox(width: 25,),
                        Text("Add Food Items",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                      ],
                     ),
              
                  ),
                  
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}

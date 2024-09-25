
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailController = TextEditingController();
String email="";
final _formKey = GlobalKey<FormState>();

resetPassword()async{
try{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
    "Reset Link Sent to Email",
    style: TextStyle(fontSize: 18),
    )));

}on FirebaseAuthException catch(e){
  if(e.code=="user-not-found"){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
      "No User Found for that E-mail",
      style: TextStyle(fontSize: 18),
      )));
  }
  }
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 70,),
        Container(
          alignment: Alignment.center,
          child: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
          ),
          ),
          const SizedBox(height: 10,),
          const Text(
            "Enter Your Email Address to Reset Password",
            style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
            ),
            Expanded(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller:mailController ,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please Enter Email";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Email",
                      
                      hintStyle: TextStyle(fontSize: 18,color: Colors.white),
                      prefixIcon: Icon(Icons.person,color: Colors.white70,size: 30,),
                      border: InputBorder.none
                   
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                    GestureDetector(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email=mailController.text;
                            
                          });
                          resetPassword();
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white ),
                          child: const Center(
                            child: Text(
                              "Send Request",
                              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ),

              const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",style: TextStyle(color: Colors.white,fontSize: 18),),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()));
                  },
                  child: const Text("Create",style: TextStyle(color: Color.fromARGB(255,184,166,6),fontSize: 24,fontWeight:FontWeight.w500),)),
              ],
            )

              ],
            ),
            ),
            ),
            ),
            
      ],
      ),
      ),
    );
  }
}
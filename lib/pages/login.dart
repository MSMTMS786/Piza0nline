import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in/admin/admin_login.dart';
import 'package:sign_in/pages/bottomnav.dart';
import 'package:sign_in/pages/forgot_password.dart';
import 'package:sign_in/pages/signup.dart';
import 'package:sign_in/widgets/wigdets%20_support.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
final _formKey = GlobalKey<FormState>();
String email = "";
String password = "";
TextEditingController useremailController =TextEditingController();
TextEditingController userpasswordController =TextEditingController();

userLogin() async {
  
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
     Navigator.push(context, MaterialPageRoute(builder: (context)=>const BottomNav()));
     print("$email          $password",);
    }on FirebaseAuthException catch(e){
     if(e.code=="user-not-found"){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User not found",style: TextStyle(fontSize: 18,color: Colors.black),),),
        );
    }else if(e.code=="wrong-password"){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Wrong Password",style: TextStyle(fontSize: 18,color: Colors.black),),),
        );
    }
    }
}

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
                    colors: [Color(0xffff5c30), Color(0xffe74b1a), Colors.yellow],
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Text(""),
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
                        child: Form(
                          key: _formKey,

                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Login",
                                style: AppWidget.HeadlineTextFieldStyle(),
                              ),
                              TextFormField(
                                controller: useremailController,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return "Please enter email";
                                  }
                                  return null;
                                 
                                },
                                decoration: InputDecoration(
                                    hintText: "E-Mail",
                                    hintStyle: AppWidget.semiBoldTextFieldStyle(),
                                    prefixIcon: const Icon(Icons.email_outlined)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: userpasswordController,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return "Please enter Pasword";
                                  }
                                  return null;
                                 
                                },
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    
                                    hintText: "Password",
                                    hintStyle: AppWidget.semiBoldTextFieldStyle(),
                                    prefixIcon: const Icon(Icons.password_sharp),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText ? Icons.visibility : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Forgot Password?",
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(_formKey.currentState!.validate())
                                  {
                                    setState(() {
                                      email = useremailController.text;
                                    password = userpasswordController.text;

                                    
                                    });
                                  }
                                  userLogin();
                                
                                },
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffff5722),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: const Center(
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Poppins"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: AppWidget.semiBoldTextFieldStyle(),
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
                            builder: (context) => const AdminLogin(),
                          ),
                        );
                      },

                      child: const Text(
                        "Login as a Admin",
                        style:  TextStyle(
                          
                          color:Color(0xffff5722),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
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

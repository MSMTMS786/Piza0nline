import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sign_in/service/shared_pref.dart';
import 'package:sign_in/widgets/app_constants.dart';
import 'package:sign_in/widgets/wigdets%20_support.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
String? wallet;
int? add;
getthesharedpref()async{
  wallet=await SharedPrefrenceHelper().getUserWallet();
  setState(() {
    
  });
}

ontheload()async{
  await getthesharedpref();
  setState(() {
    
  });
}
 void initState(){
  ontheload();
  super.initState();
 }



  Map<String,dynamic>?paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet==null? CircularProgressIndicator(): Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text('Wallet',style:AppWidget.HeadlineTextFieldStyle(),), ), ), ),
               const SizedBox(height: 30,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xfff2f2f2)
                  ),
                  child:  Row(
                    children: [
                      Image.asset('images/wallet.png',width: 50,height: 50,fit: BoxFit.cover,),
                      const SizedBox(width: 30,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Balance',style: AppWidget.LightTextFieldStyle(),),
                          const SizedBox(height: 5,),
                          Text('\$ '+wallet!,style: AppWidget.boldTextFieldStyle(),)
                        ],
                      )
                    ],),
                ),
                const SizedBox(height: 20,),
              Padding(

                padding: const EdgeInsets.only(left: 20.0),
                child: Text("Add Money",style: AppWidget.boldTextFieldStyle(),),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      makePayment("100");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$100",style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment("500");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$500",style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                 GestureDetector(
                    onTap: (){
                      makePayment("1000");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$1000",style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      makePayment("2000");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("\$2000",style: AppWidget.semiBoldTextFieldStyle(),),
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 50,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff008080),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(child: Text("Add Money",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Poppins",fontWeight: FontWeight.bold),),),
              )
          ],
        ),
        ),
      
    );
  }
  Future<void> makePayment(String amount)async{
    try{
      paymentIntent=await createPaymentIntent(amount, "USD");
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret:paymentIntent!['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'Misbah Ur Rehman',
      )).then((value){});
      displayPaymentSheet(amount);
    }catch(e,s){
      print('exception $e$s');
    }
  }
  displayPaymentSheet(String amount)async{
    try{
      await Stripe.instance.presentPaymentSheet().then((value)async{
        // it will add the amount to the wallet
        add=int.parse(wallet!)+int.parse(amount);
        await SharedPrefrenceHelper().saveUserWallet(add.toString());

        
        showDialog(context: context, builder: (_)=>const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle,color: Colors.green,),Text("Payment Successful")
                ],
              )
            ],
          ),
        ));
      await getthesharedpref();
        paymentIntent=null;
      
      }).onError((error,StackTrace){
        print('error is:-------> $error   $StackTrace');
      });
      
    }on StripeException catch(e){
      print('Error is ----------> $e');
      showDialog(context: context, builder: (_)=>const AlertDialog(
        content: Text('Payment Failed'),
      ));
      
  }catch (e){
    print("$e");
  }
}
createPaymentIntent(String amount,String currency)async{
  try{
    Map<String,dynamic> body={
        'amount':calculateAmount(amount),
        'currency':currency,
        'payment_method_types[]':'card'
    };
    var response=await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization':'Bearer  $secretKey',
        'Content-Type':'application/x-www-form-urlencoded'
      },
      body: body,
    );
    print("Payment Intent Body--->> ${response.body.toString()}");
    return jsonDecode(response.body);
  }catch(err){
    print('Err charging user: ${err.toString()}');
  }
}
calculateAmount(String amount){
 final calculatedAmount=(int.parse(amount)*100).toString();

  return calculatedAmount;
  }

}
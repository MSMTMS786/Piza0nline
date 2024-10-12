import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sign_in/service/database.dart';
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
  String? wallet = "0.00", id;
  TextEditingController amountController = TextEditingController();
  int? add;
  getthesharedpref() async {
    wallet = await SharedPrefrenceHelper().getUserWallet();
    id = await SharedPrefrenceHelper().getUserId();
    setState(() {
      wallet = wallet; // Ensure wallet is updated correctly
    });
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  void initState() {
    ontheload();
    super.initState();
  }

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // wallet==null? Center(child: CircularProgressIndicator()):
      body: Container(
        margin: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    'Wallet',
                    style: AppWidget.HeadlineTextFieldStyle(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Color(0xfff2f2f2)),
              child: Row(
                children: [
                  Image.asset(
                    'images/wallet.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: AppWidget.LightTextFieldStyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$' + wallet!,
                        style: AppWidget.boldTextFieldStyle(),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Add Money",
                style: AppWidget.boldTextFieldStyle(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    makePayment("100");
                    calculateAmount("100");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$100",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    makePayment("500");
                    calculateAmount("500");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$500",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    makePayment("1000");
                    calculateAmount("1000");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$1000",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    makePayment("2000");
                    calculateAmount("2000");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$2000",
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                openEdit();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff008080),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Add Money",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "USD");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'Misbah Ur Rehman',
          ))
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception $e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        // Add amount to wallet after payment success

        await addToWallet(int.parse(amount));
        add = int.parse(amount) + int.parse(wallet!);
        await DataBaseMethods().UpdateUserwallet(id!, add.toString());
        // Show successful payment dialog
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    Text("Payment Successful")
                  ],
                )
              ],
            ),
          ),
        );

        paymentIntent = null;
      }).onError((error, StackTrace) {
        print('Error during payment: $error\n$StackTrace');
      });
    } on StripeException catch (e) {
      print('Stripe error: $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text('Payment Failed'),
        ),
      );
    } catch (e) {
      print('Unknown error: $e');
    }
  }

// Update Wallet Function
  Future<void> addToWallet(int amountToAdd) async {
    // Get the current wallet balance from shared preferences
    String? currentWalletBalance =
        await SharedPrefrenceHelper().getUserWallet();

    // Parse the current balance to an integer, default to 0 if null
    int currentBalance = int.tryParse(currentWalletBalance ?? '0') ?? 0;

    // Log the current balance for debugging
    print("Current Wallet Balance: $currentBalance");

    // Add the specified amount to the current balance
    int newBalance = currentBalance + amountToAdd;

    // Save the updated balance back to shared preferences
    await SharedPrefrenceHelper().saveUserWallet(newBalance.toString());

    // Log the updated balance for debugging
    print("New Wallet Balance: $newBalance");

    // Update the state to reflect the new balance in the UI
    setState(() {
      wallet = newBalance.toString();
    });
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer  $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print("Payment Intent Body--->> ${response.body.toString()}");
      return jsonDecode(response.body);
    } catch (err) {
      print('Err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100).toString();

    return calculatedAmount;
  }

  Future openEdit() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.cancel)),
                        const SizedBox(
                          width: 50,
                        ),
                        const Text(
                          "Add Money",
                          style: TextStyle(
                              color: Color(0xff008080),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Amount"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: amountController,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "Enter Amount"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          makePayment(amountController.text);
                          calculateAmount(amountController.text);
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xff008080),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}

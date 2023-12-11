
import 'dart:io';
import 'dart:math';

import 'package:edfapg_sample/credentials.dart';
import 'package:edfapg_sample/actions/capture_page.dart';
import 'package:edfapg_sample/actions/get_transaction_detail_page.dart';
import 'package:edfapg_sample/actions/sale_page.dart';
import 'package:edfapg_sample/transaction-storage.dart';
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:flutter/material.dart';
import 'actions/credit_void_page.dart';
import 'actions/get_transaction_status_page.dart';
import 'actions/recurring_sale_page.dart';
import 'global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EdfaPgSdk.instance.config(
    key: CLIENT_KEY, // Create a string variable which should be fill by 'Client Key' provided by expresspay.sa
    password: CLIENT_PASSWORD, // Create a string variable which should be fill by 'Client Password' provided by expresspay.sa
    enableDebug: true
  );

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpressPaySDK',
      theme: ThemeData(
        primarySwatch: MaterialColor(primaryColor.value, swatch),
      ),
      home:  ActionsPage(),
    );
  }
}


class ActionsPage extends StatelessWidget{

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("ExpressPaySDKSample"),
        actions: const [
          TextButton(onPressed: Transaction.clear, child: Text("Clear", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            button("SALE", sale),
            button("RECURRING_SALE", recurringSale),
            button("CAPTURE", capture),
            button("CREDIT_VOID", creditVoid),
            button("GET_TRANS_STATUS", transSatus),
            button("GET_TRANS_DETAILS", transDetail),
            button("SALE_WITH_CARD_UI", saleWithCard),
            if(Platform.isIOS)
              button("APPLE_PAY", applePay),
          ],
        ),
      ),
    );
  }

  sale(){
    Navigator.of(context).push(pageRoute(SalePage()));
  }

  recurringSale(){
    Transaction.getRecurringSale().then((value){
      Navigator.of(context).push(pageRoute(RecurringSalePage(value)));
    });
  }

  capture(){
    Transaction.getAll().then((value){
      Navigator.of(context).push(pageRoute(CapturePage(value)));
    });
  }

  creditVoid(){
    Transaction.getAll().then((value){
      Navigator.of(context).push(pageRoute(CreditVoidPage(value)));
    });
  }

  transDetail(){
    Transaction.getAll().then((value){
      Navigator.of(context).push(pageRoute(TransactionDetailPage(value)));
    });
  }

  transSatus(){
    Transaction.getAll().then((value){
      Navigator.of(context).push(pageRoute(TransactionStatusPage(value)));
    });
  }

  saleWithCard(){

    final order = EdfaPgSaleOrder(
        id: EdfaPgSdk.instance.HELPER.generateUUID(), description: "Test Order",
        currency: "SAR", amount: 0.10//Random().nextInt(9)/10, // will not exceed 0.9
    );

    final payer = EdfaPgPayer(
        firstName: "Zohaib", lastName: "Kambrani",
        address: "Express Pay", country: "SA", city: "Riyadh", zip: "123768",
        email: "a2zzuhaib@gmail.com", phone: "+966500409598",
        ip: "66.249.64.248",
        options: EdfaPgPayerOption( // Options
            middleName: "Muhammad Iqbal",
            birthdate: DateTime.parse("1987-03-30"),
            address2: "King Fahad Road", state: "Olaya"
        )
    );

    EdfaCardPay()
        .setOrder(order)
        .setPayer(payer)
        .onTransactionSuccess((response){
          print("onTransactionSuccess.response ===> ${response.toString()}");
          alert(context, "Success :)");


    }).onTransactionFailure((response){
      print("onTransactionFailure.response ===> ${response.toString()}");
      alert(context, "Failure :(");

    }).onError((error){
      print("onError.response ===> ${error.toString()}");
      alert(context, "Error:\n${error}");

    }).initialize(context);
  }

  applePay() async{
    final order = EdfaPgSaleOrder(
        id: EdfaPgSdk.instance.HELPER.generateUUID(), description: "Test Order",
        currency: "SAR", amount: 0.10//Random().nextInt(9)/10, // will not exceed 0.9
    );

    final payer = EdfaPgPayer(
        firstName: "Zohaib", lastName: "Kambrani",
        address: "Express Pay", country: "SA", city: "Riyadh", zip: "123768",
        email: "a2zzuhaib@gmail.com", phone: "+966500409598",
        ip: "66.249.64.248",
        options: EdfaPgPayerOption( // Options
            middleName: "Muhammad Iqbal",
            birthdate: DateTime.parse("1987-03-30"),
            address2: "King Fahad Road", state: "Olaya"
        )
    );

    EdfaApplePay()
        .setOrder(order)
        .setPayer(payer)
        .setApplePayMerchantID("merchant.expresspay.darlana")
        .onAuthentication((response){
      print("onAuthentication.response ===> ${response.toString()}");
      alert(context, "Authorized :)");

    }).onTransactionSuccess((response){
      print("onTransactionSuccess.response ===> ${response.toString()}");
      alert(context, "Success :)");

    }).onTransactionFailure((response){
      print("onTransactionFailure.response ===> ${response.toString()}");
      alert(context, "Failure :(");

    }).onError((error){
      print("onError.response ===> ${error.toString()}");
      alert(context, "Error:\n${error}");

    }).initialize(context);
  }

}

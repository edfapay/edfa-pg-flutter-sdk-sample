
import 'dart:io';
import 'dart:math';

import 'package:expresspay_sample/Credentials.dart';
import 'package:expresspay_sample/sale_page.dart';
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:flutter/material.dart';
import 'global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ExpresspaySdk.instance.config(
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
      appBar: AppBar(title: const Text("ExpressPaySDKSample")),
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
    alert(context, "Under Development");
  }

  capture(){
    alert(context, "Under Development");
  }

  creditVoid(){
    alert(context, "Under Development");
  }

  transDetail(){
    alert(context, "Under Development");
  }

  transSatus(){
    alert(context, "Under Development");
  }

  saleWithCard(){

    final order = ExpresspaySaleOrder(
        id: ExpresspaySdk.instance.HELPER.generateUUID(), description: "Test Order",
        currency: "SAR", amount: 0.10//Random().nextInt(9)/10, // will not exceed 0.9
    );

    final payer = ExpresspayPayer(
        firstName: "Zohaib", lastName: "Kambrani",
        address: "Express Pay", country: "SA", city: "Riyadh", zip: "123768",
        email: "a2zzuhaib@gmail.com", phone: "+966500409598",
        ip: "66.249.64.248",
        options: ExpresspayPayerOption( // Options
            middleName: "Muhammad Iqbal",
            birthdate: DateTime.parse("1987-03-30"),
            address2: "King Fahad Road", state: "Olaya"
        )
    );

    ExpressCardPay()
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
    final order = ExpresspaySaleOrder(
        id: ExpresspaySdk.instance.HELPER.generateUUID(), description: "Test Order",
        currency: "SAR", amount: 0.10//Random().nextInt(9)/10, // will not exceed 0.9
    );

    final payer = ExpresspayPayer(
        firstName: "Zohaib", lastName: "Kambrani",
        address: "Express Pay", country: "SA", city: "Riyadh", zip: "123768",
        email: "a2zzuhaib@gmail.com", phone: "+966500409598",
        ip: "66.249.64.248",
        options: ExpresspayPayerOption( // Options
            middleName: "Muhammad Iqbal",
            birthdate: DateTime.parse("1987-03-30"),
            address2: "King Fahad Road", state: "Olaya"
        )
    );

    ExpressApplePay()
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

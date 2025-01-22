
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:edfapg_sample/change-language-page.dart';
import 'package:edfapg_sample/credentials.dart';
import 'package:edfapg_sample/actions/capture_page.dart';
import 'package:edfapg_sample/actions/get_transaction_detail_page.dart';
import 'package:edfapg_sample/actions/sale_page.dart';
import 'package:edfapg_sample/transaction-storage.dart';
import 'package:edfapg_sdk/credentials.dart';
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:flutter/material.dart';
import 'actions/credit_void_page.dart';
import 'actions/get_transaction_status_page.dart';
import 'actions/recurring_sale_page.dart';
import 'global.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EdfaPgSdk.instance.config(
    key: Credentials().MERCHANT_KEY, // Create a string variable which should be fill by 'Client Key' provided by expresspay.sa
    password: Credentials().MERCHANT_PASSWORD, // Create a string variable which should be fill by 'Client Password' provided by expresspay.sa
    enableDebug: true
  );

  runApp(
      EasyLocalization(
        supportedLocales: locales.values.toList(),
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('ar', 'SA'),
        startLocale: Locale('ar', 'SA'),
        useOnlyLangCode: true,
        child: const MyApp(),
      )
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edfa Payment Gateway SDK',
      theme: ThemeData(
        primarySwatch: MaterialColor(primaryColor.value, swatch),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
        title: const Text("EdfaPaySDKSample"),
        actions: const [],
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
            const Divider(height: 30, thickness: 1, color: Colors.black),
            button("Clear Transaction Cache", Transactions.clear),
            button("Change Language", changeLanguage),
          ],
        ),
      ),
    );
  }

  sale(){
    Navigator.of(context).push(pageRoute(SalePage()));
  }

  recurringSale(){
    Transactions.getRecurringSale().then((value){
      Navigator.of(context).push(pageRoute(RecurringSalePage(value)));
    });
  }

  capture(){
    Transactions.getAll().then((value){
      Navigator.of(context).push(pageRoute(CapturePage(value)));
    });
  }

  creditVoid(){
    Transactions.getAll().then((value){
      Navigator.of(context).push(pageRoute(CreditVoidPage(value)));
    });
  }

  transDetail(){
    Transactions.getAll().then((value){
      Navigator.of(context).push(pageRoute(TransactionDetailPage(value)));
    });
  }

  transSatus(){
    Transactions.getAll().then((value){
      Navigator.of(context).push(pageRoute(TransactionStatusPage(value)));
    });
  }

  saleWithCard(){

    final order = EdfaPgSaleOrder(
        id: EdfaPgSdk.instance.HELPER.generateUUID(), description: "Test Order",
        currency: "SAR", amount: 1.00//Random().nextInt(9)/10, // will not exceed 0.9
    );

    final payer = EdfaPgPayer(
      firstName: "Zohaib",
      lastName: "Kambrani",
      address: "Riyadh",
      country: "SA",
      city: "Riyadh",
      zip: "123123",
      email: "a2zzuhaib@gmail.com",
      phone: "966500409598",
      ip: "171.100.100.123",
      // options: EdfaPgPayerOption( // Options
      //     // middleName: "Muhammad Iqbal",
      //     // birthdate: DateTime.parse("1987-03-30"),
      //     // address2: "King Fahad Road", state: "Olaya"
      // )
    );

    EdfaCardPay()
        .setOrder(order)
        .setPayer(payer)
        .setDesignType(EdfaPayDesignType.one)
        .setLanguage(EdfaPayLanguage.en)
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

   saleWithCardDetails() {
    final order = EdfaPgSaleOrder(
        id: EdfaPgSdk.instance.HELPER.generateUUID(),
        description: "Test Order",
        currency: "SAR",
        amount: 0.12 //Random().nextInt(9)/10, // will not exceed 0.9
    );

    final payer = EdfaPgPayer(
      firstName: "Zohaib",
      lastName: "Kambrani",
      address: "Riyadh",
      country: "SA",
      city: "Riyadh",
      zip: "123123",
      email: "a2zzuhaib@gmail.com",
      phone: "+966500409598",
      ip: "171.100.100.123",
      // options: EdfaPgPayerOption( // Options
      //     // middleName: "Muhammad Iqbal",
      //     // birthdate: DateTime.parse("1987-03-30"),
      //     // address2: "King Fahad Road", state: "Olaya"
      // )
    );


    // final card = EdfaPgCard(number: "4458271329748293",
    //     expireMonth: 7,
    //     expireYear: 2029,
    //     cvv: "331");//zohaib card

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

  changeLanguage(){
    Navigator.of(context).push(pageRoute(ChangeLanguagePage()));
  }

}


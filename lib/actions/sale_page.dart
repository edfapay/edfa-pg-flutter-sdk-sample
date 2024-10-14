import 'dart:convert';
import 'dart:math';

import '../inheritable/loading_flag.dart';
import 'package:edfapg_sample/components/card_types.dart';
import 'package:edfapg_sample/components/recurring_option.dart';
import 'package:edfapg_sample/global.dart';
import 'package:edfapg_sample/transaction-storage.dart';
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SalePageState();

}

class SalePageState extends State<SalePage> with LoadingFlag{
  var faker = Faker();

  // Order:
  TextEditingController id = TextEditingController(text: "");
  TextEditingController amount = TextEditingController(text: "");
  TextEditingController desc = TextEditingController(text: "");
  TextEditingController currency = TextEditingController(text: "");

  // Payer:
  TextEditingController firstName = TextEditingController(text: "");
  TextEditingController lastName = TextEditingController(text: "");
  TextEditingController country = TextEditingController(text: "");
  TextEditingController countryCode = TextEditingController(text: "");
  TextEditingController city = TextEditingController(text: "");
  TextEditingController zip = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");
  TextEditingController phone = TextEditingController(text: "");
  TextEditingController ip = TextEditingController(text: "");

  // Payer Options:
  TextEditingController middleName = TextEditingController(text: "");
  TextEditingController address = TextEditingController(text: "");
  TextEditingController state = TextEditingController(text: "");
  TextEditingController dob = TextEditingController(text: "");

  // Optional:
  TextEditingController channelId = TextEditingController(text: "");

  TextEditingController response = TextEditingController(text: "");

  EdfaPgCard? selectedCard;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ExpressPaySDKSample")),
      body: SafeArea(
        top: false, bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              button("Randomize All", randomize),
              const SizedBox(height: 20),

              boldLabel("Order:"),
              textField(id, hint: "ID"),
              textField(amount, hint: "Amount"),
              textField(desc, hint: "Description"),
              textField(currency, hint: "Currency (SAR)"),

              seperator(),

              boldLabel("Payer:"),
              textField(firstName, hint: "First Name"),
              textField(lastName, hint: "Last Name"),
              textField(country, hint: "Country"),
              textField(countryCode, hint: "Country Code (SA)"),
              textField(city, hint: "City"),
              textField(zip, hint: "ZIP"),
              textField(email, hint: "Email"),
              textField(phone, hint: "Phone/Mobile"),
              textField(ip, hint: "IP"),

              seperator(),

              boldLabel("Payer Options:"),
              textField(middleName, hint: "Middle Name"),
              textField(address, hint: "Address"),
              textField(state, hint: "State"),
              textField(dob, hint: "Date of Birth"),

              seperator(),

              boldLabel("Card Type:"),
              SingleSelectionChoices(
                  onSelect: (selected){
                    selectedCard = selected;
                  },
                  items: testingCards
              ),

              seperator(),

              boldLabel("Optional:"),
              RecurringOption(
                  onChange: (isOn){
                    channelId.text = isOn ? channelId.text : "";
                  },
                  textEditingController: channelId
              ),

              seperator(),

              boldLabel("Request:"),
              Row(
                children: [
                  Expanded(child: button("Auth", auth)),
                  SizedBox(width: 10),
                  Expanded(child: button("Sale", sale)),
                ],
              ),

              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  boldLabel("Response:"),
                  Spacer(),
                  const SizedBox(
                    height: 30, width: 30,
                    // child: IconButton(onPressed: (){}, icon: Icon(Icons.copy, size: 20))
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  style: const TextStyle(fontSize: 10),
                  controller: response,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  decoration: inputDecoration(""),
                  maxLines: null,
                ).loading(loading),
              )
            ],
          ),
        ),
      ),
    );
  }

  randomize(){
    final addr = faker.address;
    final person = faker.person;
    final date = faker.date.dateTime(minYear: 1987, maxYear: 1990);
    final birthDay = ""
        "${date.year}"
        "-"
        "${date.month.toString().padLeft(2, '0')}"
        "-"
        "${date.day.toString().padLeft(2, '0')}"
        "";

    id.text = faker.guid.guid();
    amount.text = Random(1).nextDouble().toString();
    desc.text = faker.lorem.word();
    currency.text = (["SAR"]..shuffle(Random())).first;
    firstName.text = person.firstName();
    lastName.text = person.lastName();
    country.text = addr.country();
    countryCode.text = addr.countryCode();

    city.text = addr.city();
    zip.text = addr.zipCode();
    email.text = faker.internet.email();
    phone.text = faker.phoneNumber.us();
    ip.text = faker.internet.ipv4Address();
    middleName.text = (["XYZ", "ABC", "JKL"]..shuffle(Random())).first;
    address.text = addr.streetAddress();
    state.text = addr.state();
    dob.text = birthDay;
  }

  auth(){
    sale(isAuth: true);
  }

  sale({bool isAuth = false}){
    setState(startLoading);
    response.text = "";

    final order = EdfaPgSaleOrder(
        id: id.text,
        amount: double.parse(amount.text),
        description: desc.text,
        currency: currency.text
    );

    final card = EdfaPgCard(
        number: selectedCard!.number,
        expireMonth: selectedCard!.expireMonth,
        expireYear: selectedCard!.expireYear,
        cvv: selectedCard!.cvv
    );

    final payer = EdfaPgPayer(
        firstName: firstName.text,
        lastName: lastName.text,
        address: address.text,
        country: countryCode.text,
        city: city.text,
        zip: zip.text,
        email: email.text,
        phone: phone.text,
        ip: ip.text,
        options: EdfaPgPayerOption( // Options
            middleName: middleName.text,
            birthdate: DateTime.parse(dob.text),
            address2: address.text,
            state: state.text
        )
    );

    EdfaPgSaleOption? saleOption;
    if(channelId.text.isNotEmpty) {
      saleOption = EdfaPgSaleOption(channelId: channelId.text, recurringInit: true) ;
    }

    final txn = Transactions(cardNumber: card.number ?? "", payerEmail: email.text, isAuth: isAuth);
    EdfaPgSdk.instance.ADAPTER.SALE.execute(
        order: order,
        card: card,
        payer: payer,
        saleOption: saleOption,
        isAuth: isAuth,
        onResponse: SaleResponseCallback(
            success: (EdfaPgSaleSuccess result) {
              debugPrint(result.toJson().toString());
              txn.fill(result).save();
            },
            decline: (EdfaPgSaleDecline result) {
              debugPrint(result.toJson().toString());
              txn.fill(result).save();
            },
            recurring: (EdfaPgSaleRecurring result) {
              debugPrint(result.toJson().toString());
              txn.fill(result).save();
            },
            redirect: (EdfaPgSaleRedirect result) {
              debugPrint(result.toJson().toString());
              txn.fill(result).save();
            },
            secure3d: (EdfaPgSale3DS result) {
              debugPrint(result.toJson().toString());
              txn.fill(result).save();
            },
            error: (EdfaPgError result) {
              debugPrint(result.toJson().toString());
            }
        ),
        onResponseJSON: (data){
          setState(endLoading);
          response.text = prettyPrint(data);
        },
        onFailure: (result) {
          debugPrint(result.toJson().toString());
        }
    );

  }
}
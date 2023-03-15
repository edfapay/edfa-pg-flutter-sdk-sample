import 'dart:convert';
import 'dart:math';

import 'package:expresspay_sample/components/card_types.dart';
import 'package:expresspay_sample/components/recurring_option.dart';
import 'package:expresspay_sample/global.dart';
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalePage extends StatelessWidget{
  var faker = Faker();

  // Order:
  TextEditingController id = TextEditingController(text: "ID");
  TextEditingController amount = TextEditingController(text: "Amount");
  TextEditingController desc = TextEditingController(text: "Description");
  TextEditingController currency = TextEditingController(text: "Currency");

  // Payer:
  TextEditingController firstName = TextEditingController(text: "First Name");
  TextEditingController lastName = TextEditingController(text: "Last Name");
  TextEditingController country = TextEditingController(text: "Country");
  TextEditingController countryCode = TextEditingController(text: "Country Code");
  TextEditingController city = TextEditingController(text: "City");
  TextEditingController zip = TextEditingController(text: "ZIP");
  TextEditingController email = TextEditingController(text: "Email");
  TextEditingController phone = TextEditingController(text: "Phone");
  TextEditingController ip = TextEditingController(text: "IP Address");

  // Payer Options:
  TextEditingController middleName = TextEditingController(text: "Middle Name");
  TextEditingController address = TextEditingController(text: "Address");
  TextEditingController state = TextEditingController(text: "State");
  TextEditingController dob = TextEditingController(text: "Date of Birth");

  // Optional:
  TextEditingController channelId = TextEditingController(text: "Channel ID");

  TextEditingController response = TextEditingController(text: "");

  ExpresspayCard? selectedCard;


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
              textField(id),
              textField(amount),
              textField(desc),
              textField(currency),

              seperator(),

              boldLabel("Payer:"),
              textField(firstName),
              textField(lastName),
              textField(country),
              textField(countryCode),
              textField(city),
              textField(zip),
              textField(email),
              textField(phone),
              textField(ip),

              seperator(),

              boldLabel("Payer Options:"),
              textField(middleName),
              textField(address),
              textField(state),
              textField(dob),

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
                ),
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

    final order = ExpresspaySaleOrder(
        id: id.text,
        amount: double.parse(amount.text),
        description: desc.text,
        currency: currency.text
    );

    final card = ExpresspayCard(
        number: selectedCard!.number,
        expireMonth: selectedCard!.expireMonth,
        expireYear: selectedCard!.expireYear,
        cvv: selectedCard!.cvv
    );

    final payer = ExpresspayPayer(
        firstName: firstName.text,
        lastName: lastName.text,
        address: address.text,
        country: countryCode.text,
        city: city.text,
        zip: zip.text,
        email: email.text,
        phone: phone.text,
        ip: ip.text,
        options: ExpresspayPayerOption( // Options
            middleName: middleName.text,
            birthdate: DateTime.parse(dob.text),
            address2: address.text,
            state: state.text
        )
    );

    ExpresspaySaleOption? saleOption;
    if(channelId.text.isNotEmpty) {
      saleOption = ExpresspaySaleOption(channelId: channelId.text, recurringInit: true) ;
    }

    ExpresspaySdk.instance.ADAPTER.SALE.execute(
        order: order,
        card: card,
        payer: payer,
        saleOption: saleOption,
        isAuth: isAuth,
        onResponse: SaleResponseCallback(
            success: (ExpresspaySaleSuccess result) {
              debugPrint(result.toJson().toString());
            },
            decline: (ExpresspaySaleDecline result) {
              debugPrint(result.toJson().toString());
            },
            recurring: (ExpresspaySaleRecurring result) {
              debugPrint(result.toJson().toString());
            },
            redirect: (ExpresspaySaleRedirect result) {
              debugPrint(result.toJson().toString());
            },
            secure3d: (ExpresspaySale3DS result) {
              debugPrint(result.toJson().toString());
            },
            error: (ExpresspayError result) {
              debugPrint(result.toJson().toString());
            }
        ),
        onResponseJSON: (data){
          response.text = prettyPrint(data);
        },
        onFailure: (result) {
          debugPrint(result.toJson().toString());
        }
    );

  }
}
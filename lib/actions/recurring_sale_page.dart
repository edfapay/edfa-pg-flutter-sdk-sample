import 'dart:math';

import 'package:edfapg_sample/global.dart';
import 'package:edfapg_sample/inheritable/transaction_state.dart';
import 'package:edfapg_sample/transaction-storage.dart';
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../inheritable/loading_flag.dart';

class RecurringSalePage extends StatefulWidget {
  List<Transaction> transactions;
  RecurringSalePage(this.transactions);

  @override
  State<StatefulWidget> createState() => RecurringSalePageState(transactions);
}


var _faker = Faker();
class RecurringSalePageState extends TransactionState<RecurringSalePage> with LoadingFlag{
  RecurringSalePageState(List<Transaction> transactions) : super(transactions);

  // Order:
  TextEditingController txnId = TextEditingController(text: "");
  TextEditingController recurringToken = TextEditingController(text: "");
  
  TextEditingController orderId = TextEditingController(text: "");
  TextEditingController amount = TextEditingController(text: "");
  TextEditingController desc = TextEditingController(text: "");

  TextEditingController response = TextEditingController(text: "");


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
              boldLabel("Select Transaction:"),
              transactionsWidget(context),


              if(selectedTxn != null)
                ...[
                  seperator(),
                  boldLabel("Selected Transaction:"),
                  Text(prettyPrint(selectedTxn!.toJson()), style: TextStyle(fontSize: 12),),
                ],

              seperator(),

              boldLabel("Recurring:"),
              textField(txnId, hint: "Transaction ID"),
              textField(recurringToken, hint: "Recurring Token"),

              seperator(),

              boldLabel("Order:"),
              textField(orderId, hint: "Order ID"),
              textField(amount, hint: "Amount"),
              textField(desc, hint: "Order Description"),
              button("Randomize", randomize),

              seperator(),
              
              boldLabel("Request:"),
              Row(
                children: [
                  Expanded(child: button("R. Auth", auth)),
                  SizedBox(width: 10),
                  Expanded(child: button("R. Sale", sale)),
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

  Widget transactionsWidget(BuildContext context){
    if(transactions.isEmpty){
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.black.withOpacity(0.05),
        height: 100,
        child: const Center(
          child: Text("NO TRANSACTIONS AVAILABLE FOR RECURRING SALE", style: TextStyle(fontSize: 11, color: Colors.red, fontWeight: FontWeight.bold)),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.width/2, minHeight: 50),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, idx){
              final txn = transactions[idx];
              final selected = txn == selectedTxn;
              return InkWell(
                onTap: () => setState(() {
                  selectedTxn = txn;
                  txnId.text = selectedTxn?.txnId ?? "";
                  recurringToken.text = selectedTxn?.recurringToken ?? "";
                }),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      border: Border.all(width: 2,  color: selected ? Colors.blueAccent : Colors.transparent)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(txn.action?.action ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                          const Text(" | "),
                          Text(txn.status?.status ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                          const Text(" | "),
                          Text(txn.payerEmail ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                        ],
                      ),
                      // Text("ID: ${txn.id}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13)),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, idx) => Container(margin: EdgeInsets.all(2), height: 0.25, color: Colors.black12),
            itemCount: transactions.length
        ),
      ),
    );
  }


  randomize(){
    orderId.text = _faker.guid.guid();
    amount.text = Random(1).nextDouble().toString();
    desc.text = _faker.lorem.word();
  }

  auth(){
    sale(isAuth: true);
  }

  sale({bool isAuth = false}){
    setState(startLoading);
    response.text = "";

    final order = EdfaPgOrder(
        id: orderId.text,
        amount: double.parse(amount.text),
        description: desc.text,
    );

    final recurringOptions = EdfaPgRecurringOptions(
        firstTransactionId: selectedTxn?.txnId ?? "",
        token:  selectedTxn?.recurringToken ?? ""
    );

    final txn = selectedTxn;
    txn?.isAuth = isAuth;
    EdfaPgSdk.instance.ADAPTER.RECURRING_SALE.execute(
        cardNumber: selectedTxn?.cardNumber ?? "",
        isAuth: isAuth,
        order: order,
        payerEmail: selectedTxn?.payerEmail ?? "",
        recurringOptions: recurringOptions,
        onResponse: RecurringSaleResponseCallback(
            success: (EdfaPgSaleSuccess result) {
              debugPrint(result.toJson().toString());
              txn?.fill(result).save();
            },
            decline: (EdfaPgSaleDecline result) {
              debugPrint(result.toJson().toString());
              txn?.fill(result).save();
            },
            recurring: (EdfaPgSaleRecurring result) {
              debugPrint(result.toJson().toString());
              txn?.fill(result).save();
            },
            redirect: (EdfaPgSaleRedirect result) {
              debugPrint(result.toJson().toString());
              txn?.fill(result).save();
            },
            secure3d: (EdfaPgSale3DS result) {
              debugPrint(result.toJson().toString());
              txn?.fill(result).save();
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
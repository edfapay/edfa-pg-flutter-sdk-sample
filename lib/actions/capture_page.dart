
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sample/global.dart';
import 'package:edfapg_sample/inheritable/loading_flag.dart';
import 'package:edfapg_sample/inheritable/transaction_state.dart';
import 'package:edfapg_sample/transaction-storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CapturePage extends StatefulWidget {
  List<Transactions> transactions;
  CapturePage(this.transactions);

  @override
  State<StatefulWidget> createState() => CapturePageState(transactions);
}


class CapturePageState extends TransactionState<CapturePage> with LoadingFlag{
  CapturePageState(List<Transactions> transactions) : super(transactions);

  TextEditingController amount = TextEditingController(text: "");
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

              boldLabel("Optional:"),
              textField(amount, hint: "Partial Amount"),

              seperator(),

              boldLabel("Request:"),
              Row(
                children: [
                  Expanded(child: button("Capture", capture)),
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

  capture(){
    setState(startLoading);
    response.text = "";

    final txn = selectedTxn;
    double? amount_ = double.tryParse(amount.text) ?? 0.0;
    amount_ = amount_ > 0.0 ? amount_ : null;
    EdfaPgSdk.instance.ADAPTER.CAPTURE.execute(
        amount: amount_,
        transactionId: selectedTxn?.txnId ?? "",
        cardNumber: selectedTxn?.cardNumber ?? "",
        payerEmail: selectedTxn?.payerEmail ?? "",
        onResponse: CaptureResponseCallback(
            success: (EdfaPgCaptureSuccess result){
              debugPrint(result.toJson().toString());
              txn?.fill(result).save();
            },
            decline: (EdfaPgCaptureDecline result){
              debugPrint(result.toJson().toString());
              txn?.fill(result).save();
            },
            error: (EdfaPgError result){
              debugPrint(result.toJson().toString());
            }
        ),
        onResponseJSON: (data){
          response.text = prettyPrint(data);
          setState(endLoading);
        },
        onFailure: (result) {
          debugPrint(result.toJson().toString());
        }
    );

  }
}
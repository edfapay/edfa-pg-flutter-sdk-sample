import 'dart:convert';

import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transaction{
  String? payerEmail;
  String cardNumber;

  String? txnId;
  String? orderId;
  ExpresspayAction? action;
  ExpresspayResult? result;
  ExpresspayStatus? status;

  String  recurringToken = "";
  bool isAuth;

  Transaction({required this.payerEmail, required this.cardNumber, required this.isAuth});

  Map<String, dynamic> toJson(){
    return {
      "payerEmail":payerEmail,
      "cardNumber":cardNumber,
      "txnId":txnId,
      "orderId":orderId,
      "action":action?.action,
      "result":result?.result,
      "status":status?.status,
      "recurringToken":recurringToken,
      "isAuth":isAuth
    };
  }

  static Transaction fromJson(Map<String, dynamic> json){
    final ob = Transaction(payerEmail: json["payerEmail"], cardNumber: json["cardNumber"], isAuth: json["isAuth"]);
    ob.txnId = json["txnId"] ?? "";
    ob.orderId = json["orderId"] ?? "";
    ob.recurringToken = json["recurringToken"] ?? "";
    ob.isAuth = json["isAuth"] ?? false;
    ob.action = ExpresspayAction.of(json["action"]);
    ob.result = ExpresspayResult.of(json["result"]);
    ob.status = ExpresspayStatus.of(json["status"]);
    return ob;
  }


  Transaction fill(IExpresspayResult result){
    this.txnId = result.transactionId;
    this.orderId = result.orderId;
    this.action = result.action;
    this.result = result.result;
    this.status = result.status;
    if((result is ExpresspaySaleRecurring?)) {
      this.recurringToken = (result as ExpresspaySaleRecurring?)?.recurringToken ?? "";
    }
    return this;
  }

  save() async{
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList("Transactions") ?? [];
    list.add(jsonEncode(toJson()));
    pref.setStringList("Transactions", list);
  }

  static Future<List<Transaction>> getAll() async{
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList("Transactions") ?? [];
    return list.map((e) => Transaction.fromJson(jsonDecode(e))).toList();
  }

  static Future<List<Transaction>> getRecurringSale() async{
    final l = await getAll();
    return l.where((element) => element.action == ExpresspayAction.SALE).toList();
  }

  static Future<List<Transaction>> getCapture() async{
    final l = await getAll();
    return l.where((e) => e.action == ExpresspayAction.SALE && e.isAuth).toList();
  }

  static Future<List<Transaction>> getCreditVoid() async{
    final l = await getAll();
    return l.where((e) => e.action == ExpresspayAction.SALE || e.action == ExpresspayAction.CAPTURE || e.isAuth).toList();
  }

  static clear() async{
    final pref = await SharedPreferences.getInstance();
    pref.setStringList("Transactions", []);
  }
}
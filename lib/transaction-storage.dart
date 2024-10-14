import 'dart:convert';

import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transactions{
  String? payerEmail;
  String cardNumber;

  String? txnId;
  String? orderId;
  EdfaPgAction? action;
  EdfaPgResult? result;
  EdfaPgStatus? status;

  String  recurringToken = "";
  bool isAuth;

  Transactions({required this.payerEmail, required this.cardNumber, required this.isAuth});

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

  static Transactions fromJson(Map<String, dynamic> json){
    final ob = Transactions(payerEmail: json["payerEmail"], cardNumber: json["cardNumber"], isAuth: json["isAuth"]);
    ob.txnId = json["txnId"] ?? "";
    ob.orderId = json["orderId"] ?? "";
    ob.recurringToken = json["recurringToken"] ?? "";
    ob.isAuth = json["isAuth"] ?? false;
    ob.action = EdfaPgAction.of(json["action"]);
    ob.result = EdfaPgResult.of(json["result"]);
    ob.status = EdfaPgStatus.of(json["status"]);
    return ob;
  }


  Transactions fill(IEdfaPgResult result){
    this.txnId = result.transactionId;
    this.orderId = result.orderId;
    this.action = result.action;
    this.result = result.result;
    this.status = result.status;
    if((result is EdfaPgSaleRecurring?)) {
      this.recurringToken = (result as EdfaPgSaleRecurring?)?.recurringToken ?? "";
    }
    return this;
  }

  save() async{
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList("Transactions") ?? [];
    list.add(jsonEncode(toJson()));
    pref.setStringList("Transactions", list);
  }

  static Future<List<Transactions>> getAll() async{
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList("Transactions") ?? [];
    return list.map((e) => Transactions.fromJson(jsonDecode(e))).toList();
  }

  static Future<List<Transactions>> getRecurringSale() async{
    final l = await getAll();
    return l.where((element) => element.action == EdfaPgAction.SALE).toList();
  }

  static Future<List<Transactions>> getCapture() async{
    final l = await getAll();
    return l.where((e) => e.action == EdfaPgAction.SALE && e.isAuth).toList();
  }

  static Future<List<Transactions>> getCreditVoid() async{
    final l = await getAll();
    return l.where((e) => e.action == EdfaPgAction.SALE || e.action == EdfaPgAction.CAPTURE || e.isAuth).toList();
  }

  static clear() async{
    final pref = await SharedPreferences.getInstance();
    pref.setStringList("Transactions", []);
  }
}
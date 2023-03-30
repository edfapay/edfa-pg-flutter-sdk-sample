import 'package:expresspay_sample/transaction-storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin LoadingFlag{
  bool loading = false;

  startLoading() => loading = true;
  endLoading() => loading = false;

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../transaction-storage.dart';

abstract class TransactionState<T extends StatefulWidget> extends State<T>{
  List<Transactions> transactions;
  Transactions? selectedTxn;

  TransactionState(this.transactions);

  @override
  Widget build(BuildContext context);


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
                onTap: () => setState(() => selectedTxn = txn),
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
}
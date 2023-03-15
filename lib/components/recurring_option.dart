import 'package:expresspay_sample/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecurringOption extends StatefulWidget {
  final Function(bool) onChange;
  final TextEditingController textEditingController;
  const RecurringOption({required this.onChange, required this.textEditingController});

  @override
  State<RecurringOption> createState() => _RecurringOptionState();
}

class _RecurringOptionState extends State<RecurringOption> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    final tint = Theme.of(context).primaryColor;
    return Container(
      margin:  const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      color: Colors.black.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              label("Init Recurring Sale"),
              Spacer(),
              CupertinoSwitch(value: isOn, onChanged: (isOn){
                setState(() {
                  this.isOn = isOn;
                  widget.onChange(isOn);
                });

              }),
            ],
          ),
          textField(widget.textEditingController)
        ],
      ),
    );
  }
}
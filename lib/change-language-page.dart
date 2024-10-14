import 'package:easy_localization/easy_localization.dart';
import 'package:edfapg_sample/global.dart';
import 'package:edfapg_sample/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeLanguagePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Change Language"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(10),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            for(int i = 0; i < locales.length; i++)
              ChoiceChip(
                  onSelected: (selected){
                    final locale = locales.entries.elementAt(i).value;
                    if(context.locale != locale){
                      context.setLocale(locale);
                      Navigator.pop(context);
                    }
                  },
                  label: Text(locales.entries.elementAt(i).key),
                  selected: locales.entries.elementAt(i).value == context.locale,
              )
          ],
        ),
      ),
    );
  }

  onSelected(Locale locale){

  }
}
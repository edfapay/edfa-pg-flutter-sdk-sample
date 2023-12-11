import 'dart:convert';
import 'dart:ui';
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:flutter/material.dart';

List<EdfaPgCard> testingCards = EdfaPgTestCards().all();

const primaryColor =  Color(0xff1d6cf3);
const primaryTextColor =  Colors.black;
const secondaryTextColor =  Colors.white;

Map<int, Color> swatch = {
  50:primaryColor.withOpacity(0.1),
  100:primaryColor.withOpacity(0.2),
  200:primaryColor.withOpacity(0.3),
  300:primaryColor.withOpacity(0.4),
  400:primaryColor.withOpacity(0.5),
  500:primaryColor.withOpacity(0.6),
  600:primaryColor.withOpacity(0.7),
  700:primaryColor.withOpacity(0.8),
  800:primaryColor.withOpacity(0.9),
  900:primaryColor.withOpacity(1),
};

Widget button(String text, VoidCallback action){
  return Padding(
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(onPressed: action, child: Text(text)),
  );
}

MaterialPageRoute pageRoute(Widget page){
  return MaterialPageRoute(builder: (ctx){
    return page;
  });
}

inputDecoration(String hint) => InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    border: const OutlineInputBorder(),
    hintText: hint,
);

Widget textField(TextEditingController controller, {String? hint}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: SizedBox(
      height: 40,
      child: TextField(
        style: const TextStyle(fontSize: 13),
          controller: controller,
          decoration: inputDecoration(hint ?? "")
      ),
    ),
  );
}

boldLabel(String text) => Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15));
label(String text) => Text(text, style: const TextStyle(fontSize: 15));

seperator() => Container(height: 0.5, color: Colors.black, margin: const EdgeInsets.symmetric(vertical: 30));

alert(BuildContext context ,String message){
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

String prettyPrint(Map json){
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  final String jsonString = encoder.convert(json);
  return jsonString;
}

extension xLoading on Widget{

  loading(bool loading){
    return Stack(
      children: [
        this,
        if(loading)
          const Positioned(
            top: 0, bottom: 0, right: 0, left: 0,
              child: Center(
                  child: CircularProgressIndicator()
              )
          )
      ],
    );
  }
}

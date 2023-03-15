import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleSelectionChoices extends StatefulWidget {
  final Function(dynamic) onSelect;
  final List<dynamic> items;
  const SingleSelectionChoices({required this.onSelect, required this.items});

  @override
  State<SingleSelectionChoices> createState() => _SingleSelectionChoicesState();
}

class _SingleSelectionChoicesState extends State<SingleSelectionChoices> {
  dynamic _value;

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
          Wrap(
            spacing: 5.0,
            children: widget.items.map((e) {
              return ChoiceChip(
                selectedColor: Theme.of(context).primaryColor,
                label: Text(e.toString(), style: TextStyle(color: _value == e ? Colors.white : Colors.black)),
                selected: _value == e,
                onSelected: (bool selected) {
                  setState(() {
                    _value = e;
                    widget.onSelect(_value);
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
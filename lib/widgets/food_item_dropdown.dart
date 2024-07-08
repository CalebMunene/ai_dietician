import 'package:flutter/material.dart';

class FoodItemDropdown extends StatelessWidget {
  final List<String> foodItems;
  final String selectedItem;
  final void Function(String?)? onChanged; // Corrected type

  FoodItemDropdown({required this.foodItems, required this.selectedItem, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem,
      onChanged: onChanged,
      items: foodItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

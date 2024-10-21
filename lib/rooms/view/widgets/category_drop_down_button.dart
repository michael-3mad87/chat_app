import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';

class CategoryDropDownButton extends StatefulWidget {
  final void Function(String?) onCategorySelected;
  const CategoryDropDownButton({
    super.key,
    required this.onCategorySelected,
  });

  @override
  State<CategoryDropDownButton> createState() => _CategoryDropDownButtonState();
}

class _CategoryDropDownButtonState extends State<CategoryDropDownButton> {
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedCategory,
      hint: Text(
        'Select Category',
        style: TextStyle(color: AppTheme.primaryColor),
      ),
      items: ['Sports', 'Movies', 'Music']
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category,
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value;
          widget.onCategorySelected(selectedCategory);
        });
      },
      isExpanded: true,
      validator: (value) {
        if (value == null) {
          return "You should choose category";
        }
        return null;
      },
    );
  }
}

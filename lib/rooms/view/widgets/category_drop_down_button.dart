import 'package:chat_app/rooms/data/models/category_model.dart';
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
  String? selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedCategoryId,
      hint: Text(
        'Select Category',
        style: TextStyle(color: AppTheme.primaryColor),
      ),
      items: CategoryModel.categories
          .map(
            (category) => DropdownMenuItem(
              value: category.id,
              child: Row(
                children: [
                  Image.asset('assets/images/${category.imageName}.png' , height: 28,),
                  const SizedBox(width: 10,),
                  Text(
                    category.name,
                    style: TextStyle(color: AppTheme.primaryColor),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (categoryId) {
        setState(() {
          selectedCategoryId = categoryId;
          widget.onCategorySelected(selectedCategoryId);
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

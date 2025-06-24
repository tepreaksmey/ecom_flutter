import 'package:ecom_flutter/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class CategoryChips extends StatefulWidget {
  final Function(String category) onCategorySelected;
  const CategoryChips({super.key, required this.onCategorySelected});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectedIndex = 0;
  final categories = ['All', 'Computer', 'Clothes', 'Accesseries'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(
                categories[index],
                style: AppTextstyle.withColor(
                  selectedIndex == index
                      ? AppTextstyle.withWeight(
                          AppTextstyle.bodySmall,
                          FontWeight.w600,
                        )
                      : AppTextstyle.bodySmall,
                  selectedIndex == index
                      ? Colors.white
                      : isDark
                      ? Colors.grey[300]!
                      : Colors.grey[600]!,
                ),
              ),
              selected: selectedIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  selectedIndex = selected ? index : selectedIndex;
                });
                widget.onCategorySelected(categories[selectedIndex]);
              },
              selectedColor: Theme.of(context).primaryColor,
              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: selectedIndex == index ? 2 : 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 1,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: BorderSide(
                color: selectedIndex == index
                    ? Colors.transparent
                    : isDark
                    ? Colors.grey[700]!
                    : Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

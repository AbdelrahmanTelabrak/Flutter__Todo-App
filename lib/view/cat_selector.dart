import 'package:flutter/material.dart';
import 'package:flutter_todo/common/widgets/buttons.dart';

class CategorySelector extends StatefulWidget {
  final Function chooseCat;

  const CategorySelector({super.key, required this.chooseCat});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String selectedPath = 'assets/icons/ic_cat_task.svg';

  bool selected = false;

  int _tabIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'assets/icons/ic_cat_task.svg',
      'assets/icons/ic_cat_event.svg',
      'assets/icons/ic_cat_goal.svg'
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _tabIndex = index;
              widget.chooseCat(categories[index]);
            },
            customBorder: const CircleBorder(),
            child: catSelector(
                iconPath: categories[index], isSelected: _tabIndex==index),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: categories.length,
    );
    // return Row(
    //   children: [
    //     InkWell(
    //       onTap: () {
    //         selected = !selected;
    //         widget.updateCat();
    //       },
    //       customBorder: const CircleBorder(),
    //       child: catSelector(iconPath: 'assets/icons/ic_cat_task.svg', isSelected: selected),
    //     ),
    //     const SizedBox(width: 16),
    //     catSelector(iconPath: 'assets/icons/ic_cat_event.svg'),
    //     const SizedBox(width: 16),
    //     catSelector(iconPath: 'assets/icons/ic_cat_goal.svg'),
    //   ],
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_todo/common/widgets/buttons.dart';
import 'package:flutter_todo/common/widgets/texts.dart';

class PrioritySelector extends StatefulWidget {
  final Function choosePriority;

  const PrioritySelector({super.key, required this.choosePriority});

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  bool selected = false;

  int _tabIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<String> priorities = [
      '1',
      '2',
      '3',
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            _tabIndex = index;
            widget.choosePriority(priorities[index]);
          },
          customBorder: const CircleBorder(),
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getPrioColor(priorities[index]),
              border: Border.all(
                width: 3,
                  color: _tabIndex == index
                      ? const Color(0xff4A3780)
                      : Colors.white),
            ),
            child: semiBoldText(priorities[index]),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemCount: priorities.length,
    );
  }
  
  Color getPrioColor(String pr){
    if (pr == '1') {
      return const Color(0xffe1fcd1);
    }  
    else if (pr == '2') {
      return const Color(0xfffcf3d1);
    }  
    return const Color(0xFFFFB0B0);
  }
}

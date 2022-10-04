import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {

  final TabController controller;

  const BottomNavBar({Key? key, required this.controller}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      items: List.generate(4, (index) => BottomNavigationBarItem(
        icon: const Icon(Icons.add),
        label: 'Page ${index + 1}',
      )),
      currentIndex: widget.controller.index,
      unselectedItemColor: Colors.grey.shade300,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      onTap: changeIndex,
    );
  }

  changeIndex(int index) {
    widget.controller.index = index;
  }
}


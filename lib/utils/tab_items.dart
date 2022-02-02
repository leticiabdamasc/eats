import 'package:flutter/material.dart';

class TabItems extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  const TabItems(
      {Key? key,
      required this.text,
      required this.icon,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                icon,
                color: isSelected ? Colors.red : Colors.grey,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

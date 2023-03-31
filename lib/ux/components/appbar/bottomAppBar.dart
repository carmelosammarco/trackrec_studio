import 'package:flutter/material.dart';

class BottomNavigationMenu extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color selectedColor = Colors.yellow;
  final Color defaultColor = Colors.black;

  const BottomNavigationMenu(
      {required this.icon,
      required this.label,
      required this.onTap,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedColor : defaultColor, 
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: isSelected ? selectedColor : defaultColor,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
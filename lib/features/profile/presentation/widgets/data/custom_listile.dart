import 'package:flutter/material.dart';

class CustomListile extends StatelessWidget {
  const CustomListile({
    super.key,
    required this.color,
    required this.titleColor,
    required this.icon,
    required this.title,
    this.onTap,
    required this.trailingIcon,
    required this.trailingIconColor,
  });

  final Color color;
  final Color titleColor;
  final IconData icon;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, color: titleColor),
      ),
      trailing: Icon(trailingIcon, size: 16, color: trailingIconColor),
      onTap: onTap,
    );
  }
}

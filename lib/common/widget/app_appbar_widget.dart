import 'package:flutter/material.dart';
import 'package:getxstudentrecorderhive/common/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSize? bottom;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.bottom,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: AppColor.appFGColor,
      backgroundColor: AppColor.appBGColor,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      leading: leading,
      bottom: bottom,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );
}

import 'package:flutter/material.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? titleText;
  final Widget? action;
  final Widget? leading;
  final Color? backgroundColor;
  final bool hideBack;
  final double? height;
  final TextStyle? titleStyle;
  final IconData? leadingIcon;

  const BasicAppbar({
    this.title,
    this.titleText,
    this.hideBack = false,
    this.action,
    this.backgroundColor,
    this.height,
    this.leading,
    this.titleStyle,
    this.leadingIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ??
          Theme.of(context).appBarTheme.backgroundColor ??
          Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: height ?? 70,
      titleSpacing: 0,
      leadingWidth: leading != null ? 150 : null,
      title:
          title ??
          (titleText != null
              ? Text(
                  titleText!,
                  style:
                      titleStyle ??
                      const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                )
              : const SizedBox.shrink()),
      actions: [action ?? const SizedBox.shrink()],
      leading: leading ??
    (hideBack
        ? null
        : IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Colors.white, size: 20),
            onPressed: () {
              Navigator.of(context).pop(); // أضمن طريقة للرجوع
            },
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 80);
}

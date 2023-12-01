import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Signify',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Image.asset("assets/logo/sanket_icon.png"),
        onPressed: () {},
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget? get child => null;
}

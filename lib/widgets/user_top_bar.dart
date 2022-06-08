import 'package:flutter/material.dart';

class UserTopBar extends StatelessWidget {
  final IconButton leadingIconButton;
  const UserTopBar({required this.leadingIconButton, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingIconButton,
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const UserOrders()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const UserBag()));
          },
        ),
      ],
    );
  }
}

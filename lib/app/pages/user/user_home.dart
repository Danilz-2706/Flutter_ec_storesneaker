import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/widgets/product_banner.dart';
import 'package:ec_storesneaker/widgets/products_display.dart';
import 'package:ec_storesneaker/widgets/user_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHome extends ConsumerWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserTopBar(
                leadingIconButton: IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () {
                    // sign out
                    ref.read(firebaseAuthProvider).signOut();
                  },
                ),
              ),
              const SizedBox(height: 20),
              const ProductBanner(),
              const SizedBox(height: 20),
              const Text(
                "Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text("View all of our products",
                  style: TextStyle(fontSize: 12)),
              const Flexible(child: ProductsDisplay()),
            ],
          ),
        ),
      ),
    );
  }
}

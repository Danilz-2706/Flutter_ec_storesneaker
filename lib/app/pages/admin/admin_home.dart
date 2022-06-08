import 'package:ec_storesneaker/app/pages/admin/admin_add_product.dart';
import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/models/product.dart';
import 'package:ec_storesneaker/utils/snackbars.dart';
import 'package:ec_storesneaker/widgets/project_list_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AdminAddProductPage())),
      ),
      appBar: AppBar(
        title: const Text('Admin Home'),
        actions: [
          IconButton(
              onPressed: () => ref.read(firebaseAuthProvider).signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: ref.read(databaseProvider)!.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("No products yet..."),
                    Lottie.asset("assets/anim/empty.json", // here
                        width: 200,
                        repeat: false),
                  ],
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.5),
                    child: ProductListTile(
                        product: product,
                        onDelete: () async {
                          openIconSnackBar(
                            context,
                            "Deleting item...",
                            const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          );
                          await ref
                              .read(databaseProvider)!
                              .deleteProduct(product.id!);
                        }),
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

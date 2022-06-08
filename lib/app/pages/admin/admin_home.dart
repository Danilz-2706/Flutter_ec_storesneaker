import 'package:ec_storesneaker/app/pages/admin/admin_add_product.dart';
import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text("Price: ${product.price}"),
                    leading: product.imageUrl != ""
                        ? Image.network(product.imageUrl, height: 300)
                        : Container(),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => ref
                          .read(databaseProvider)!
                          .deleteProduct(product.id!),
                    ),
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

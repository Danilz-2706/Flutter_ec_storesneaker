import 'package:ec_storesneaker/app/components/custom_input_field.dart';
import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminAddProductPage> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final titleTextEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            CustomInputFieldFb1(
              inputController: titleTextEditingController,
              hintText: 'Product Name',
              labelText: 'Productname',
            ),
            const SizedBox(height: 15),
            CustomInputFieldFb1(
              inputController: descriptionEditingController,
              hintText: 'Product Descriptio',
              labelText: 'Product Descriptio',
            ),
            const SizedBox(height: 15),
            CustomInputFieldFb1(
              inputController: priceEditingController,
              hintText: 'Price',
              labelText: 'Price',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _addProduct(),
              child: const Text("Add product"),
            ),
          ],
        ),
      ),
    );
  }

  _addProduct() async {
    final storage = ref.read(databaseProvider);
    if (storage == null) {
      return;
    }

    await storage.addProduct(
      Product(
        name: titleTextEditingController.text,
        description: descriptionEditingController.text,
        price: double.parse(priceEditingController.text),
        imageUrl: "img",
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}

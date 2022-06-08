import 'dart:io';

import 'package:ec_storesneaker/app/components/custom_input_field.dart';
import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
        child: SingleChildScrollView(
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
              ElevatedButton(
                child: const Text('Upload Image'),
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    ref.watch(addImageProvider.state).state = image;
                  }
                },
              ),
              Consumer(
                builder: (context, watch, child) {
                  final image = ref.watch(addImageProvider);
                  return image == null
                      ? const Text('No image selected')
                      : Image.file(
                          File(image.path),
                          height: 200,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addProduct() async {
    final storage = ref.read(databaseProvider);
    final fileStorage = ref.read(storageProvider); // reference file storage
    final imageFile =
        ref.read(addImageProvider.state).state; // referece the image File
    if (storage == null || fileStorage == null || imageFile == null) {
      // ignore: avoid_print
      print("Error: storage, fileStorage or imageFile is null");
      return;
    }

    // Upload to Filestorage
    final imageUrl = await fileStorage.uploadFile(
      // upload File using our
      imageFile.path,
    );

    await storage.addProduct(
      Product(
        name: titleTextEditingController.text,
        description: descriptionEditingController.text,
        price: double.parse(priceEditingController.text),
        imageUrl: imageUrl,
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}

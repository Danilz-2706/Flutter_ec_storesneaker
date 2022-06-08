import 'package:ec_storesneaker/app/pages/user/user_bag.dart';
import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/models/product.dart';
import 'package:ec_storesneaker/widgets/user_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetail extends ConsumerWidget {
  final Product product;
  const ProductDetail({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              UserTopBar(
                leadingIconButton: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 15),
              Hero(
                tag: product.name,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "My Store",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w300,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                product.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Description",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                product.description,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    "\$" + product.price.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  ref.read(bagProvider).addProduct(product); // Adds a product
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const UserBag()));
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      " Add to Bag",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

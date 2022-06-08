import 'package:ec_storesneaker/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  final Function()? onPressed;
  final Function() onDelete;
  const ProductListTile(
      {required this.product, this.onPressed, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (c) => onDelete(), // function to delete
            backgroundColor: const Color(0xFFFE4A49), // a red color
            foregroundColor: Colors.white,
            icon: Icons.delete, // Delete icon
            label: 'Delete', // Delete text
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) onPressed!();
        },
        child: Container(
          width: screenSize.width,
          height: 75,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(10, 20),
                  blurRadius: 10,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.05)),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(product.imageUrl,
                      height: 59, fit: BoxFit.cover)),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: screenSize.width / 2.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(product.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    Text(product.description,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                "\$" + product.price.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

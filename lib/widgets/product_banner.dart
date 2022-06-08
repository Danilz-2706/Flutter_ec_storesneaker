import 'package:flutter/material.dart';

class ProductBanner extends StatelessWidget {
  const ProductBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 175,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color.fromARGB(255, 255, 123, 0), Colors.black],
            ),
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("New Release",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )),
                SizedBox(height: 10),
                Text("Cool shoes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32)),
              ],
            ),
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/shoe2.png?alt=media&token=8c9f66f4-bbfb-42f2-80ce-1811e7d7fab7",
              width: 125,
            )
          ],
        ));
  }
}

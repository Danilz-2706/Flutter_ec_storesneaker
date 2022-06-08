import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/models/order.dart';
import 'package:ec_storesneaker/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserOrders extends ConsumerWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: StreamBuilder<List<Order>>(
          stream: ref.read(databaseProvider)!.getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data != null) {
              if (snapshot.data!.isEmpty) {
                return const EmptyWidget();
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final order = snapshot.data![index];
                    final total = order.products
                        .map(((e) => e.price))
                        .reduce((value, element) => value + element);

                    return Padding(
                        padding: const EdgeInsets.all(8.5),
                        child: ListTile(
                          title: Text(
                              order.products.map((e) => e.name).join(', ')),
                          subtitle: Text(order.timestamp.toDate().toString()),
                          trailing: Text("\$" + total.toString()),
                        ));
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

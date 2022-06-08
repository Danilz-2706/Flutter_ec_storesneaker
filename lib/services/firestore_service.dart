import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_storesneaker/models/product.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    await firestore
        .collection("products")
        .add(product.toMap())
        // ignore: avoid_print
        .then((value) => print(value))
        // ignore: avoid_print
        .catchError((onError) => print("Error"));
  }

  Stream<List<Product>> getProducts() {
    return firestore
        .collection("products") // gets collection
        .snapshots() // gets snapshots, loop through
        .map((snapshot) => snapshot.docs.map((doc) {
              // loop through docs
              final d = doc.data(); // for each doc get the data
              return Product.fromMap(d); // convert into a map
            }).toList()); // build a list out of the products mapping
  }
}

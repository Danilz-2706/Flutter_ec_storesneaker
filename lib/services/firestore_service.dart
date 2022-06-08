import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_storesneaker/models/order.dart';
import 'package:ec_storesneaker/models/product.dart';
import 'package:ec_storesneaker/models/user_data.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///----------------------------------PRODUCT----------------------------------///
  Future<void> addProduct(Product product) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId).set(product.toMap(docId));
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

  ///----------------------------------USER----------------------------------///
  Future<void> deleteProduct(String id) async {
    return await firestore.collection("products").doc(id).delete();
  }

  Future<void> addUser(UserData user) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

  ///----------------------------------ORDER----------------------------------///
  Future<void> saveOrder(String confirmationId, List<Product> products) async {
    // Save the order in the orders collection of the user
    await firestore.collection("users").doc(uid).collection("orders").add({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(product.id!)).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });
    // Save the order on an outer collection for the admin / user depending on your design decision.
    await firestore.collection("orders").doc(confirmationId).set({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(product.id!)).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Order>> getOrders() {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }
}

import 'package:ec_storesneaker/services/firestore_service.dart';
import 'package:ec_storesneaker/services/payment_service.dart';
import 'package:ec_storesneaker/services/storage_service.dart';
import 'package:ec_storesneaker/view_models/bag_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// firebaseAuthProvider which will provide us with the FirebaseAuth.instance which is used to perform Authentication operations
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

///atuhStateChangesProvider that will provide us with authentication changes that happen through our app
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final databaseProvider = Provider<FirestoreService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return FirestoreService(uid: uid);
  }
  return null;
});

// Create an image provider with riverpod
final addImageProvider = StateProvider<XFile?>((_) => null);

final storageProvider = Provider<StorageService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return StorageService(uid: uid);
  }
  return null;
});

final bagProvider = ChangeNotifierProvider<BagViewModel>((ref) {
  return BagViewModel();
});

final paymentProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});

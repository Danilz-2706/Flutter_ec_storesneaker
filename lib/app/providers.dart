import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// firebaseAuthProvider which will provide us with the FirebaseAuth.instance which is used to perform Authentication operations
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

///atuhStateChangesProvider that will provide us with authentication changes that happen through our app
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

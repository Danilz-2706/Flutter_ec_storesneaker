import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key? key,
    required this.nonSignedInBuilder,
    required this.signedInBuilder,
    required this.adminSignedInBuilder,
  }) : super(key: key);

  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;
  final WidgetBuilder adminSignedInBuilder;

  final adminEmail = "admin@admin.com";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChange = ref.watch(authStateChangesProvider);
    const adminEmail = "admin@admin.com";
    return authStateChange.when(
        data: (user) => user != null
            ? user.email == adminEmail
                ? adminSignedInBuilder(context)
                : signedInBuilder(context)
            : nonSignedInBuilder(context),
        error: (_, __) => const Scaffold(
              body: Center(
                child: Text("Something went wrong"),
              ),
            ),
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  FutureBuilder<UserData?> signedInHandler(context, WidgetRef ref, User user) {
    final database = ref.read(databaseProvider)!;
    final potentialUserFuture = database.getUser(user.uid);
    return FutureBuilder<UserData?>(
        future: potentialUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final potentialUser = snapshot.data;
            if (potentialUser == null) {
              database.addUser(UserData(
                  email: user.email != null ? user.email! : "",
                  uid: user
                      .uid)); // no need to await as you don't depend on that
            }
            if (user.email == adminEmail) {
              return adminSignedInBuilder(context);
            }
            return signedInBuilder(context);
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

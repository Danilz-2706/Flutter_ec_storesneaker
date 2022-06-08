import 'package:ec_storesneaker/app/providers.dart';
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
}

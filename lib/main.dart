import 'package:ec_storesneaker/app/auth_widget.dart';
import 'package:ec_storesneaker/app/pages/admin/admin_home.dart';
import 'package:ec_storesneaker/app/pages/auth/sign_in_page.dart';
import 'package:ec_storesneaker/app/providers.dart';
import 'package:ec_storesneaker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.orange,
          seedColor: Colors.orange,
        ),
      ),
      home: AuthWidget(
        signedInBuilder: (context) => Scaffold(
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Signed In in"),
              ElevatedButton(
                  onPressed: () {
                    ref.read(firebaseAuthProvider).signOut();
                  },
                  child: const Text("Sign out"))
            ],
          )),
        ),
        nonSignedInBuilder: (context) => const SignInPage(),
        adminSignedInBuilder: (context) => const AdminHome(),
      ),
    );
  }
}

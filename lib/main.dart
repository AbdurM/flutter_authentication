import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_ui_auth/src/providers/email_auth_provider.dart'
    as email_auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([email_auth.EmailAuthProvider()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Authentication Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/profile',
        routes: {
          '/sign-in': (context) {
            return SignInScreen(
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  Navigator.pushReplacementNamed(context, '/profile');
                }),
              ],
            );
          },
          '/profile': (context) {
            return ProfileScreen(
              actions: [
                SignedOutAction((context) {
                  Navigator.pushReplacementNamed(context, '/sign-in');
                }),
              ],
            );
          },
        });
  }
}

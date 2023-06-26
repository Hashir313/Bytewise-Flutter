import 'package:e_commercw_app/firebase_helper/firebase_auth.dart';
import 'package:e_commercw_app/firebase_options.dart';
import 'package:e_commercw_app/provider/app_provider.dart';
import 'package:e_commercw_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_commercw_app/screens/get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Hash Tech',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuthHelper.helper.getAuthChanges,
          builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CustomBottomBar();
          } else {
            return const GetStartedScreen();
          }
        }),
      ),
    );
  }
}

import 'package:admin_college/admin/select_uploadings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyBUwKkx2p28RtakZQBtmyGl_Z2pnNEMvYU",
    appId: "1:575502485664:android:f3c1da36168a166d09a1c5",
    messagingSenderId: "575502485664",
    projectId: "mp-college-app",
    storageBucket: "mp-college-app.appspot.com",));
  FirebaseFirestore.instance.settings =
  const Settings(persistenceEnabled: true);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SelectUploading(),
    );
  }
}

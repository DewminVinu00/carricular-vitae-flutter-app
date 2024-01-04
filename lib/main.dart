// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import
import 'package:curricular_vitae/components/skills.dart';
import 'package:curricular_vitae/pages/home_page.dart';
import 'package:curricular_vitae/pages/professional_skill_page.dart';
import 'package:curricular_vitae/pages/skill_page.dart';
import 'package:curricular_vitae/portfolio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:curricular_vitae/components/about.dart';

void main() async {
  var currentOption;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: '"AIzaSyCLmabsGMlVMkCro9WQ84hBoqIK41qq1Vs"',
    authDomain: 'curricular-vitae-9c450.firebaseapp.com',
    projectId: 'curricular-vitae-9c450',
    storageBucket: 'crudapp-b587a.appspot.com',
    messagingSenderId: '1094537173849',
    appId: '1:93524609460:android:ba42c58166a4cd516f8ae1',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dewmin Vinuraka CV',
      theme: ThemeData(
        canvasColor: Colors.purple.shade100,
        useMaterial3: true,
        fontFamily: "custom",
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(background: Colors.purple.shade50),
      ),
      home: Portfolio(),
      routes: {
        'portpolio': (context) => Portfolio(),
        'homepage': (context) => HomePage(),
        'skillpage': (context) => SkillPage(),
        'professionalskillpage': (context) => ProfessionalSkillPage(),
      },
    );
  }
}

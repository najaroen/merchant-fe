import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/material.dart';
import 'package:merchant/components/historys/history.dart';
import 'package:merchant/constant/colors.dart';
import 'package:merchant/screens/campaign-detail.dart';
import 'package:merchant/screens/campaign.dart';
import 'package:merchant/screens/create-campaign.dart';
import 'package:merchant/screens/create-point.dart';
import 'package:merchant/screens/create-promotion.dart';
import 'package:merchant/screens/register-step1.dart';
import 'package:merchant/screens/regsiter-step2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Home();
    // return CampaignDetail(
    //   collectionId: '45GlDsOjIrfetoYo2ejc',
    // );
    // return CreatePoint();
    // return CreatePromotion(
    //   campaignId: 'asds',
    // );
    // return History();
  }
}

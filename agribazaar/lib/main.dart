import 'package:agribazaar/Provider/HomeProvider.dart';
import 'package:agribazaar/Utility/Routes.dart';
import 'package:agribazaar/screens/HomeDetail.dart';
import 'package:agribazaar/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Routes.homePage,
        routes: {
          Routes.homePage: (context) => HomePage(),
          Routes.detailPage: (context) => HomeDetails(),
        },
      ),
    );
  }
}

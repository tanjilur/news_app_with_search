import 'package:flutter/material.dart';
import 'package:newsapi_49/provider/news_provider.dart';
import 'package:newsapi_49/screen/details_screen.dart';
import 'package:newsapi_49/screen/homepage.dart';
import 'package:newsapi_49/screen/search_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NewsProvider())],
      child: MaterialApp(
        routes: {
          NewsDetails.routName: (context) => NewsDetails(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomePage(),
        home: SearchPage(),
      ),
    );
  }
}

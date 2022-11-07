import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newsapi_49/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsDetails extends StatelessWidget {
  static String routName = "newsDetails";
  const NewsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var publishAt = ModalRoute.of(context)!.settings.arguments as String;
    var currentData = Provider.of<NewsProvider>(context).findByDate;
    return Scaffold(
      appBar: AppBar(
        title: Text("${currentData}"),
      ),
    );
  }
}

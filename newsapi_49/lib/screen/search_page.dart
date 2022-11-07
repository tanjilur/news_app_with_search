import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newsapi_49/model/news_model.dart';
import 'package:newsapi_49/provider/news_provider.dart';
import 'package:newsapi_49/widget/articles_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  List<String> searchKeyword = [
    "Flutter",
    "World",
    "Meta",
    "Football",
    "Tanju"
  ];
  //List<Articles> searchList = [];

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<NewsProvider>(context, listen: false);
    // final searchList = Provider.of<NewsProvider>(context)    .searchList;
    final searchList = searchProvider.searchList;
    //uporer List er poriborte....18no. line

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
            child: Column(children: [
          Text("Search here..."),
          TextField(
            onEditingComplete: () {
              //mobile er okey button er kaaj ekhane hobe, jeTa niche kora hoiche
            },
            controller: controller,
            decoration: InputDecoration(hintText: "search"),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () async {
//er vetorer lekhaTai onEditingComplete er vetore hobe........

              await searchProvider.getSearchData(query: controller.text);
              setState(() {});
            },
            height: 50,
            child: Text("Search"),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.8,
                    crossAxisSpacing: 8),
                itemCount: searchKeyword.length,
                itemBuilder: (context, index) {
                  return MaterialButton(
                    onPressed: () async {
                      controller.text = searchKeyword[index];
                      await searchProvider.getSearchData(
                          query: controller.text);
                      setState(() {});
                    },
                    child: Text("${searchKeyword[index]}"),
                  );
                }),
          ),
          ListView.builder(
              itemCount: searchProvider.searchList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ArticlesWidget(
                  article: searchList[index],
                );
              })
        ])),
      ),
    );
  }
}

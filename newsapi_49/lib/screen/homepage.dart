import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newsapi_49/const/const.dart';
import 'package:newsapi_49/model/news_model.dart';
import 'package:newsapi_49/provider/news_provider.dart';
import 'package:newsapi_49/service/news_api_service.dart';
import 'package:newsapi_49/widget/articles_widget.dart';
import 'package:newsapi_49/widget/news_enum.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Articles> newsList = [];

  // @override
  // void didChangeDependencies() async {
  //   newsList = await NewsApiService().fetchNewsData();
  //   setState(() {});
  //   super.didChangeDependencies();
  // }

  String sortBy = NewsEnum.popularity.name;

  @override
  void initState() {
    print(" hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $sortBy");
    super.initState();
  }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: myStyle(20, Colors.black, FontWeight.w700),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "All News",
                style: myStyle(22, Colors.black),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (currentIndex != 0) {
                            setState(() {
                              currentIndex = currentIndex - 1;
                            });
                          }
                        },
                        child: Text("< Prev")),
                    Flexible(
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = index + 1;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              color: currentIndex == index + 1
                                  ? Colors.blue
                                  : Colors.white,
                              width: 35,
                              height: 30,
                              child: Text("${index + 1}"),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = currentIndex + 1;
                          });
                        },
                        child: Text("Next >")),
                  ],
                ),
              ),
              DropdownButton<String>(
                  value: sortBy,
                  items: [
                    DropdownMenuItem(
                      child: Text("${NewsEnum.popularity.name}"),
                      value: NewsEnum.popularity.name,
                    ),
                    DropdownMenuItem(
                      child: Text("${NewsEnum.publishedAt.name}"),
                      value: NewsEnum.publishedAt.name,
                    ),
                    DropdownMenuItem(
                      child: Text("${NewsEnum.relevancy.name}"),
                      value: NewsEnum.relevancy.name,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                  }),
              FutureBuilder<List<Articles>>(
                future: providerData.getNewsData(
                    page: currentIndex, sortby: sortBy),

                // future: NewsApiService.fetchNewsData(
                //     page: currentIndex, sortby: sortBy),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      child: Text("Something is wrong...."),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ArticlesWidget(
                          article: snapshot.data![index],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

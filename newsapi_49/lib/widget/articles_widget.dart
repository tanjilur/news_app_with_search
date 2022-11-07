import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapi_49/model/news_model.dart';
import 'package:newsapi_49/screen/details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ArticlesWidget extends StatelessWidget {
  Articles? article;
  ArticlesWidget({this.article});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final article=Provider.of<Article>(context);

    //final article = Provider.of<Article>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetails(date: article.publishedAt.toString(),)));
            // Navigate to the in app details screen

            /* Navigator.pushNamed(context, NewsDetails.routeName,
                arguments: article!.publishedAt);*/

            /*  Navigator.push(
              context,
              PageTransition(

                  type: PageTransitionType.topToBottom,
                  child: Extra(),
                  inheritTheme: true,
                  ctx: context),
            );*/

            Navigator.pushNamed(context, NewsDetails.routName,
                arguments: article!.publishedAt);
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: "${article!.publishedAt}",
                        child: FancyShimmerImage(
                          height: size.height * 0.12,
                          width: size.height * 0.12,
                          boxFit: BoxFit.fill,
                          errorWidget:
                              Image.network('assets/images/empty_image.png'),
                          imageUrl: article!.urlToImage != null
                              ? "${article!.urlToImage}"
                              : "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${article!.title} ' * 100,
                            textAlign: TextAlign.justify,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            //style: smallTextStyle,
                          ),
                          // const VerticalSpacing(5),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              '🕒  200',
                              //   style: smallTextStyle,
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    /* Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: NewsDetailsWebView(
                                            url: '${article!.url} ',
                                          ),
                                          inheritTheme: true,
                                          ctx: context),
                                    );*/
                                  },
                                  icon: const Icon(
                                    Icons.link,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  '12/20/10 ',
                                  maxLines: 1,
                                  //    style: smallTextStyle,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

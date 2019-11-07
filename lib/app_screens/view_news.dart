import 'package:flutter/material.dart';
import 'package:mextv_app/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class ViewNews extends StatelessWidget {
  final NewsModel newsItem;

  ViewNews({@required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 250.00,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: CachedNetworkImage(
                  imageUrl: newsItem.featuredImage,
                  fit: BoxFit.cover,
                ),
                title: Container(
                    child: Text(newsItem.title.length <= 20
                        ? newsItem.title
                        : "${newsItem.title.substring(0, 19)}...")),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: MarkdownBody(data: html2md.convert(newsItem.content),),
        ),
      ),
    );
  }
}

String replaceText(String inputText, String whatToReplace, String replaceWith) {
  return inputText.replaceAll(whatToReplace, replaceWith);
}

Widget web(){
  return WebView();
}
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:mextv_app/components/mex_app_bar.dart';
import 'view_news.dart';
import 'package:mextv_app/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class MexNews extends StatefulWidget {
  @override
  _MexNewsState createState() => _MexNewsState();
}

class _MexNewsState extends State<MexNews> {
  static final _root = 'https://mexgh.com';
  final wp.WordPress wordPress = wp.WordPress(baseUrl: _root);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MexAppBar.create("CNews"),
      body: posts == null ? showLoader() : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return buildPost(index); //Building the posts list view
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getPosts();
  }

  Widget showLoader() {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ListTile(
            leading: CircularProgressIndicator(),
            title: Text('Loading News...'),
          ),
        ),
      ),
    );
  }

  Widget buildPost(int index) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Card(
            child: Column(
              children: <Widget>[
                buildImage(index),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(posts[index].title.rendered)),
//                    subtitle: Text(posts[index].excerpt.rendered),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewNews(
                          newsItem: NewsModel(
                              title: posts[index].title.rendered,
                              featuredImage: getImageUrl(index),
                              content: posts[index].content.rendered),
                        )));
          },
        )
      ],
    );
  }

  Widget buildImage(int index) {
    return CachedNetworkImage(
      imageUrl: getImageUrl(index),
      fit: BoxFit.cover,
    );
  }

  String getImageUrl(int index) {
    if (posts[index].featuredMedia == null) {
      return '$_root/wp-content/uploads/2019/10/76e1ee7c7bb1752715f69de03dcae5d7.jpg';
    }
    return posts[index].featuredMedia.mediaDetails.sizes.medium.sourceUrl;
  }

  Future<String> getPosts() async {
    var res = await fetchPosts();
    setState(() {
      posts = res;
    });
    return "Success!";
  }

  List<wp.Post> posts;
  Future<List<wp.Post>> fetchPosts() async {
    var posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        postStatus: wp.PostPageStatus.publish,
        orderBy: wp.PostOrderBy.date,
        order: wp.Order.desc,
      ),
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true,
      fetchCategories: true,
      fetchTags: true,
    );
    return posts;
  }
}

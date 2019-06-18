import '../models/models.dart';
import 'package:youtube_api/youtube_api.dart';

loadLiveRadio() {
  Liveradio.fromWeb((liveradioList) {
    Liveradio().saveAll(liveradioList).then((results) {
//              for (var result in results)
      print(results.toString());
    });
  });
}

loadCarouselImages() {
  Carouselimage.fromWeb((carouselimageList) {
    Carouselimage().saveAll(carouselimageList).then((results) {
      print(results.toString());
    });
  });
}

loadYoutubeVideos() async {
  const String key = "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY";
  const String channelId = "UCc1HrPSJ7fKTKi7Uol5dQ1A";
  List<Youtubevideo> videoListForDb = new List();

  YoutubeAPI ytApi = new YoutubeAPI(key, type: "channel");
  List<YT_API> ytResult = [];

  ytResult = await ytApi.channel(channelId);
  int id = 1;
  //save to database
  for (var ytVideo in ytResult) {
    Youtubevideo videoItem = Youtubevideo(
        id: id++,
        video_title: ytVideo.title,
        thumbnail: ytVideo.thumbnail['default']['url'],
        video_url: ytVideo.url,
        video_id: ytVideo.id);
    videoListForDb.add(videoItem);
  }
  if (videoListForDb.length > 0) {
    Youtubevideo().saveAll(videoListForDb).then((results) {
      print(results.toString());
    });
  }
}
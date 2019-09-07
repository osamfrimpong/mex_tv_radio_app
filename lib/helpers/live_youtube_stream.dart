import 'package:http/http.dart' as http;

bool isStreaming() {
  bool isStreaming = false;
  return isStreaming;
}

Future retrieveChannelData() async {
  const String key = "AIzaSyBii-xI-FPkR_bq5vuQQZal7K0hgCLaCRY";
  const String channelId = "UCc1HrPSJ7fKTKi7Uol5dQ1A";
  String url =
      "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=${channelId}&eventType=live&type=video&key=${key}";

  var response = await http.get(url);
  return response.body;
}

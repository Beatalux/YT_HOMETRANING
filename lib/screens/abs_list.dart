import 'package:flutter/material.dart';
import 'package:youtube_hometraining_app/utilities/keys.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_api/youtube_api.dart';

class AbslistScreen extends StatefulWidget {
  static String id = 'list_screen';
  @override
  _AbslistScreenState createState() => _AbslistScreenState();
}

class _AbslistScreenState extends State<AbslistScreen> {
  TextEditingController textController;
  ScrollController _scrollController;
  List<YT_API> _ytlist;
  List<VideoItem> videolist;
  YoutubeAPI _youtubeAPI;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController = TextEditingController();
    _youtubeAPI = YoutubeAPI(API_key, maxResults: 30);
    _ytlist = [];
    videolist = [];
    _scrollController = ScrollController();
    print('initstate');
  }

  Future<Null> callAPI(String query) async {
    print('ui called');
    if (_ytlist.isNotEmpty) {
      videolist.clear();
    }
    //query="flutter";

    _ytlist = await _youtubeAPI.search(query);
    setState(() {
      print('UI updated');
      for (YT_API result in _ytlist) {
        VideoItem item = VideoItem(
          api: result,
        );
        videolist.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: TextField(
                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(20.00),
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'YouTube 검색',
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                controller: textController,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                onSubmitted: (value) {
                  //change after I press enter
                  print('stack');
                  callAPI(value);
                  //textController.clear();
                },
//                onChanged: (value)  {
//              ;}
              ),
            ),
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(8.0),
                itemCount: videolist.length,
                itemBuilder: (_, int index) => videolist[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final YT_API api;

  VideoItem({this.api});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: ListTile(
              leading: Image.network(
                api.thumbnail["high"]["url"],
              ),
              title: Text(api.title),
              subtitle: Text(api.channelTitle),
          )
        )
    )
    ;
  }
}

//      )Center(
//        child:YoutubePlayer(
//          controller: _controller,
//
//          showVideoProgressIndicator: true,
//
//          onReady () {
//        _controller.addListener(listener);
//        },

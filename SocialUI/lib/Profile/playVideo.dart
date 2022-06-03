import 'package:shimmer/shimmer.dart';
import 'package:socialui/Home/Comment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen({key, required this.nombre}) : super(key: key);
  final String nombre;
  @override
  _PlayVideoScreenState createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  bool isLoadingSliderDetail = false;
  void initState() {
    loadingSliderDetail();
    super.initState();
  }

  loadingSliderDetail() async {
    setState(() {
      isLoadingSliderDetail = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      isLoadingSliderDetail = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingSliderDetail
        ? Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      children: [
                        customeShimerCard(),
                        SizedBox(
                          height: 10,
                        ),
                        customeShimerCard(),
                        SizedBox(
                          height: 10,
                        ),
                        customeShimerCard(),
                        SizedBox(
                          height: 10,
                        ),
                        customeShimerCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      children: [
                        customeCard(
                            "2 hours ago", "149", "20", '5', _controller1),
                        SizedBox(
                          height: 10,
                        ),
                        customeCard(
                            "3 hours ago", "30", "12", '2', _controller2),
                        SizedBox(
                          height: 10,
                        ),
                        customeCard(
                            "1 hours ago", "509", "100", '9', _controller3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  YoutubePlayerController _controller1 = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=7BmX4lZQPoY&list=RD8DOVsWe7H6U&index=25&ab_channel=Shaggy-Topic") ??
        "",
    flags: YoutubePlayerFlags(
      loop: false,
      autoPlay: false,
      mute: false,
    ),
  );

  YoutubePlayerController _controller2 = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=-VuuYprp7l8&ab_channel=Thug4Life") ??
        "",
    flags: YoutubePlayerFlags(
      loop: false,
      autoPlay: false,
      mute: false,
    ),
  );

  YoutubePlayerController _controller3 = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=xvVLWSsKjkI&ab_channel=M%C3%A4godeOz") ??
        "",
    flags: YoutubePlayerFlags(
      loop: false,
      autoPlay: false,
      mute: false,
    ),
  );

  Widget customeCard(String txt2, String likes, String coment, String share,
      YoutubePlayerController _controller1) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).backgroundColor,
      color: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/twitter2.png"),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nombre,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          letterSpacing: 0.6,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      txt2,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            letterSpacing: 0.6,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Icon(
                  Icons.more_horiz,
                  color: Color.fromARGB(255, 10, 10, 10).withOpacity(0.4),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          Container(
            height: 230,
            child: YoutubePlayer(
              controller: _controller1,
              liveUIColor: Colors.amber,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 13, bottom: 17, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                  circleColor: CircleColor(
                    start: Theme.of(context).primaryColor,
                    end: Color(0xfff78361),
                  ),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: Theme.of(context).primaryColor,
                    dotSecondaryColor: Color(0xfff78361),
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      FontAwesomeIcons.solidHeart,
                      color:
                          isLiked ? Colors.red : Color.fromARGB(255, 5, 5, 5),
                      size: 20,
                    );
                  },
                ),
                SizedBox(width: 10),
                Text(
                  likes,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        letterSpacing: 0.6,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 16, 15, 15),
                      ),
                ),
                SizedBox(width: 25),
                SizedBox(width: 10),
                Text(
                  coment,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        letterSpacing: 0.6,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 20, 20),
                      ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Icon(
                  FontAwesomeIcons.share,
                  color: Color.fromARGB(255, 24, 24, 24),
                  size: 18,
                ),
                SizedBox(width: 10),
                Text(
                  share,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        letterSpacing: 0.6,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 16, 16),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customeShimerCard() {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).textTheme.bodyText1!.color,
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
        baseColor: (Colors.grey[200]!),
        highlightColor: (Colors.grey[400]!),
        enabled: isLoadingSliderDetail,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Shimmer.fromColors(
                baseColor: (Colors.grey[200]!),
                highlightColor: (Colors.grey[400]!),
                enabled: isLoadingSliderDetail,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 13,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 13,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white.withOpacity(0.4),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 230,
              decoration: BoxDecoration(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 13, bottom: 17, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 10,
                    width: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 25),
                  Icon(
                    FontAwesomeIcons.solidCommentDots,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 10,
                    width: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Icon(
                    FontAwesomeIcons.share,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 10,
                    width: 37,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

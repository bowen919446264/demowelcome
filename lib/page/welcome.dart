import 'dart:convert';
import 'package:demonewsapp/app_constance.dart';
import 'package:demonewsapp/common/skip_down_time.dart';
import 'package:demonewsapp/common/str_util.dart';
import 'package:demonewsapp/page_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() {
    return new _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage>
    implements OnSkipClickListener {
  var welcomeImageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWelcomeImage();
    _delayedGoHomePage();
  }

  _delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 5), () {
      _goHomePage();
    });
  }

  _goHomePage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.HOME_PAGE, (Route<dynamic> route) => false);
  }

  _getWelcomeImage() async {
    String url = AppConstance.makeUrl('services/app_ad_cover.json', null);
    var response = await http.get(url);
    print(response.body);
    List list = json.decode(response.body);
    String cover = '';
    var item;
    for (item in list) {
      cover = item['field_app_ad_cover'];
      if (cover != null && cover.isNotEmpty) {
        cover = StringUtil.getSrcImagePath(cover);
        break;
      }
    }

    print('cover===$cover');
    setState(() {
      welcomeImageUrl = cover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          color: Colors.white,
          child: new Image.network(
            welcomeImageUrl,
            fit: BoxFit.cover,
          ),
          constraints: new BoxConstraints.expand(),
        ),
        new Image.asset(
          'pic/images/wenshan_wel_logon.jpg',
          fit: BoxFit.fitWidth,
        ),
        new Container(
          child: Align(
            alignment: Alignment.topRight,
            child: new Container(
              padding: const EdgeInsets.only(top: 30.0, right: 20.0),
              child: new SkipDownTimeProgress(
                Colors.red,
                22.0,
                new Duration(seconds: 5),
                new Size(25.0, 25.0),
                skipText: "跳过",
                clickListener: this,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onSkipClick() {
    _goHomePage();
  }
}

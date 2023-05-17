import 'dart:core';
import 'package:flutter/material.dart';
import 'package:notice_board/regist.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'services.dart';

import 'Post.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

// myAppState
class _MyAppState extends State<MyApp> {
  late Post _posts;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Services.getInfo().then((value) {
      setState(() {
        _posts = value;
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('게시판'),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreenStateful()),
                      );
                    },
                    icon: const Icon(Icons.add_rounded))
              ],
            ),
            body: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                Post post = _posts;
                return ListTile(
                  leading: const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.blue,
                  ),
                  trailing: Text(timeChanger(post.body.posts[index].createdAt.toString())),
                  title: Text(post.body.posts[index].title),
                );
              },
            )));
  } //
}


void flutterToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      backgroundColor: const Color(0xff6E6E6E),
      fontSize: 15,
      //textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG);
}

// 현재시간기준 얼마나 시간이 지났는지 생성 코드
String timeChanger(String time) {
  DateTime postTime = DateTime.parse(time);
  var diff = DateTime.now().difference(postTime);

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    return '${postTime.hour}:${postTime.minute}';
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      return '${diff.inDays} DAY AGO';
    } else {
      return '${diff.inDays} DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      return '${(diff.inDays / 7).floor()} WEEK AGO';
    } else {
      return '${(diff.inDays / 7).floor()} WEEKS AGO';
    }
  }
}
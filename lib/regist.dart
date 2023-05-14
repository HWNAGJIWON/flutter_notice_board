import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:notice_board/main.dart';
import 'package:http/http.dart' as http;

import 'Post.dart';

var log = Logger();
const String url = 'http://152.67.208.113:8080';
// 키보드가 텍스트 창을 가릴 때 스크롤 되도록

class RegisterScreenStateful extends StatefulWidget {
  const RegisterScreenStateful({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterScreen();
  }
}

class RegisterScreen extends State<RegisterScreenStateful> {
  final _titleEditController = TextEditingController();
  final _contentEditController = TextEditingController();
  final _pwEditController = TextEditingController();

  @override
  void dispose() {
    _pwEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 밖을 터치하면 키보드 꺼지게
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드 올라와도 글자 안 가리게
        appBar: AppBar(
          title: const Text(
            '글 쓰기',
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // 가운데로 위치시킴
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  color: Colors.red,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    '비밀번호',
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: TextField(
                    controller: _pwEditController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    decoration: const InputDecoration(
                        hintText: '4자리 숫자', counterText: ''),
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                const Flexible(
                  fit: FlexFit.tight,
                  child: Text(''),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ElevatedButton(
                      onPressed: () {
                        flutterToast("RaisedButton 클릭됨");
                        log.d("0516 비밀번호 : ${_pwEditController.text}");
                        log.d("0516 제목 : ${_titleEditController.text}");
                        log.d("0516 내용 : ${_contentEditController.text}");

                        if (_pwEditController.text.isEmpty) {
                          flutterToast("비밀번호를 입력해주세요.");
                        } else if (_titleEditController.text.isEmpty) {
                          flutterToast("제목을 입력해주세요.");
                        } else if (_contentEditController.text.isEmpty) {
                          flutterToast("내용을 입력해주세요.");
                        } else {
                          // json 만들어서 + 값 담아서

                          // http로 json 전송

                          // 메인 화면으로 라우트
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );

                          // _postRequest() async {
                          //   String url = 'http://example.com/login';
                          //
                          //   http.Response response = await http.post(
                          //     Uri.parse('$url/api/posts'),
                          //     headers: <String, String> {
                          //       'Content-Type': 'application/x-www-form-urlencoded',
                          //     },
                          //     body: <Post> {
                          //
                          //     },
                          //   );
                          // }

                          // // 이건 받을 때 하는건가?
                          // FutureBuilder(builder: (BuildContext context,
                          //     AsyncSnapshot<dynamic> snapshot) {
                          //   // 데이터 아직 못 보냈을 땐 써큘러프로그레스인디케이터
                          //   if (snapshot.hasData == false) {
                          //     return const CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
                          //   }
                          //   // 에러 발생시 에러명 텍스트에 뿌려줌
                          //   else if (snapshot.hasError) {
                          //     return Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                          //         style: const TextStyle(fontSize: 15),
                          //       ),
                          //     );
                          //   }
                          //   // 성공 시, 메인 화면으로 라우트
                          //   else {
                          //     // 메인 화면으로 라우트
                          //     Navigator.pop(context);
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => MyApp()),
                          //     );
                          //     return Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Text(
                          //         snapshot.data.toString(),
                          //         // 비동기 처리를 통해 받은 데이터를 텍스트에 뿌려줌
                          //         style: TextStyle(fontSize: 15),
                          //       ),
                          //     );
                          //   }
                          // });
                        }
                      },
                      child: const Text('글 등록')),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextField(
                    controller: _titleEditController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: '제목',
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: TextField(
                  controller: _contentEditController,
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: '내용',
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

import 'package:http/http.dart' as http;
import 'Post.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

var log = Logger();

class Services{
  static const String url = 'http://152.67.208.113:8080';

  static get body => null;

  // 게시판 전체 정보 조회하는 코드
  static Future<Post> getInfo() async{
    try{
      final response = await http.get(Uri.parse('$url/api/posts'));
      if (response.statusCode == 200){
        final Post posts = postFromJson(response.body);
        return posts;
      }
      else{
        Fluttertoast.showToast(msg: 'Error occured. Please try again.');
        log.d("0514 >> else");
        return Post(status: 201, message: '에러', body: body);
      }
    }
    catch(e){
      Fluttertoast.showToast(msg: '에러가 발생했습니다. 다시 시도해주세요.');
      log.d("0514 >> catch error");
      return Post(status: 202, message: '에러', body: body);
    }
  }
}
import 'package:http/http.dart' as http;

Future<dynamic> getPoint() async {
  var headers = {
    'Authorization': 'azo0Q5TcuAMajOgRbMSh4nG-p2VfkbBPIMukoueaQ0k'
  };
  var request = http.Request('GET', Uri.parse('localhost/point'));

  request.headers.addAll(headers);

  return await request.send();
}

Future<dynamic> getPointById(String Id) async {
  var headers = {
    'Authorization': 'azo0Q5TcuAMajOgRbMSh4nG-p2VfkbBPIMukoueaQ0k'
  };
  var request =
      http.Request('GET', Uri.parse('localhost/point/${Id.toString()}'));

  request.headers.addAll(headers);

  return await request.send();
}

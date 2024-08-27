import 'package:http/http.dart' as http;

Future<dynamic> getPromotion() async {
  var headers = {
    'Authorization': 'azo0Q5TcuAMajOgRbMSh4nG-p2VfkbBPIMukoueaQ0k'
  };
  var request = http.Request('GET', Uri.parse('localhost/promotion'));

  request.headers.addAll(headers);

  return await request.send();
}

Future<dynamic> getPromotionById(String Id) async {
  var headers = {
    'Authorization': 'azo0Q5TcuAMajOgRbMSh4nG-p2VfkbBPIMukoueaQ0k'
  };
  var request =
      http.Request('GET', Uri.parse('localhost/promotion/${Id.toString()}'));

  request.headers.addAll(headers);

  return await request.send();
}

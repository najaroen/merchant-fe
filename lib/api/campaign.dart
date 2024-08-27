import 'package:http/http.dart' as http;

Future<dynamic> getCampaigns() async {
  return await http.get(Uri.parse("localhost/getCampaign"));
}

Future<dynamic> getCampaignsById(String Id) async {
  return await http.get(Uri.parse("localhost/getCampaign/"));
}

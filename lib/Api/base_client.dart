import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl='http://192.168.137.1/Api/RMTS_BRTS/';
class BaseClient{
  var client = http.Client();

  //get
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl+api);
    var res = await client.get(url).timeout(Duration(seconds: 3));
    if(res.statusCode==200){
      return res.body;
    }else{
      return null;
      throw Exception("Cannot reach Server.");
    }
  }

  Future<dynamic> post(String api,dynamic object) async {
    var url = Uri.parse(baseUrl+api);
    // var payload = jsonEncode(object);
    var res = await client.post(url,body: object).timeout(Duration(seconds: 3));
    if(res.statusCode==200){
      print(res.body);
      return res.body;
    }else{
      return null;
      throw Exception("Cannot reach Server.");
    }
  }
}
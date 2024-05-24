import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../common/api_endpoints.dart';
class Api {

  Future<dynamic> get({
    required String endpoint,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({
      'accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYTU1ZjdmODlhNGU3MzRhMDE2Y2Q3MTg5MDQzM2M5OCIsInN1YiI6IjY2NGYwYmE1NDY2NzQ0MGY4OTM0ZDQ4YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CVyHKOueJXLhwdNMbejBMpw23x1Gh0P_vvv355bNFfg'});

    var request = http.Request('GET', Uri.parse('https://api.themoviedb.org/3/person/popular?language=en&page=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = {};

    if (response.statusCode == 200) {
      try{
        data = jsonDecode(await response.stream.bytesToString());
      }catch(err){
        data['status'] = 'error';
        data['message'] = response.reasonPhrase;
      }
    }
    else {
      data['status'] = 'error';
      data['message'] = response.reasonPhrase;
    }
    return data;
  }
}

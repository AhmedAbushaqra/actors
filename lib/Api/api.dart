import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../common/api_endpoints.dart';
class Api {

  Future<dynamic> get({
    required String endpoint,
  }) async {
    Map<String, String> headers = {};
    final token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYTU1ZjdmODlhNGU3MzRhMDE2Y2Q3MTg5MDQzM2M5OCIsInN1YiI6IjY2NGYwYmE1NDY2NzQ0MGY4OTM0ZDQ4YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CVyHKOueJXLhwdNMbejBMpw23x1Gh0P_vvv355bNFfg';
    headers.addAll({'Authorization': 'Bearer $token'});
    http.Response response = await http.post(Uri.parse(baseURL + endpoint), headers: headers);

    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      try{
        data = jsonDecode(response.body);
      }catch(err){
        data['status'] = 'error';
        data['message'] = 'server error';
      }
    } else {
      //throw Exception('There is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
      data['status'] = 'error';
      data['message'] = 'server error response';
    }

    return data;
  }
}

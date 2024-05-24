
import '../api.dart';

import '../../models/popular_model.dart';

class Populars{

  Future<Map<String, dynamic>> get({int? page}) async {

    Map<String,dynamic> data = await Api().get(endpoint: '?language=en&page=$page');
    List<PopularModel> popularList = [];
    List<dynamic> popularRequests = [];
    Map<String,dynamic> result = {};

    try{
      if (data.containsKey('results')) {
        popularRequests = data['results'];
        for (int i = 0; i < popularRequests.length; i++) {
          popularList.add(
            PopularModel.fromJson(popularRequests[i]),
          );
        }
      }
      result['popular'] = popularList;
      return result;
    }catch(e){
      result['message'] = e;
      return result;
    }

  }
}
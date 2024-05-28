import 'dart:convert';

import 'package:actors/Api/api_services/populars.dart';
import 'package:actors/common/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../models/popular_model.dart';
class PopularProvider extends ChangeNotifier{


  int pageNumber = 1;
  bool hasNextPage = true;
  bool isFirstLoadRunning = false;
  bool isLoadMoreRunning = false;
  List<PopularModel> popular = [];

  void getDataFunction (bool loadFirst) async{
    if (loadFirst == true){
        hasNextPage = true;
        isFirstLoadRunning = true;
        pageNumber = 1;
        notifyListeners();
    }
    try{
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile)
          || connectivityResult.contains(ConnectivityResult.wifi)) {
        var response =  await Populars().get(page: pageNumber);
        if (response.containsKey('popular')) {
          if (response['popular'].length > 0) {
            if (pageNumber == 1) {
              popular = response['popular'];
              List<String> listJson = popular.map((data) => jsonEncode(data.toJson())).toList();
              saveKeyAndListValueToSharedPreferences('popular', listJson);
            } else {
              popular.addAll(response['popular']);
              List<String> listJson = popular.map((data) => jsonEncode(data.toJson())).toList();
              saveKeyAndListValueToSharedPreferences('popular', listJson);
            }
          }else {
            hasNextPage = false;
          }
        }
      }else{
        var data = await getPopularListFromLocal();
        popular =data;
      }
      notifyListeners();
    }catch(err){
        isFirstLoadRunning = false;
        isLoadMoreRunning = false;
        notifyListeners();
    }
      isFirstLoadRunning = false;
      isLoadMoreRunning = false;
    notifyListeners();
  }


  Future<List<PopularModel>> getPopularListFromLocal() async {
    List<String>? popularListJson = await getKeyAndListValueFromSharedPreferences('popular');

    return popularListJson.map((data) => PopularModel.fromJson(jsonDecode(data))).toList();
  }


  Future refresh() async {
    getDataFunction(true);
  }

  Future loadMore() async {
    if (
    isFirstLoadRunning==false &&
        isLoadMoreRunning==false) {
        pageNumber += 1;
        isLoadMoreRunning = true;
        notifyListeners();
        getDataFunction(false);
    }
  }


}
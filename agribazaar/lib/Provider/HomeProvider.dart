import 'package:agribazaar/Model/HomeModel.dart';
import 'package:agribazaar/Network/RequestHelpers.dart';
import 'package:flutter/material.dart';


class HomeProvider extends ChangeNotifier{

  List<Articles> articleList = [];
  Articles selectedArticle;


  Future<void> getAllNewsFeeds() async {
    String url = 'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f7e8835c45d7420db60c7a8abd12a040';
    var response = await RequestHelpers.getRequest(url) as Map<String, dynamic>;

    if (response['status'] == 'ok') {
      print('Fetched response data: $response');
      var result =  HomeModel.fromJson(response);
      articleList = result.articles;
      /// List is sorted in A to Z order
      articleList.sort((item1, item2)=> item1.source.name.toLowerCase().compareTo(item2.source.name.toLowerCase()));
    }
    notifyListeners();
  }

  void setSelectedModelItem(int index) {
    selectedArticle = articleList[index];
    notifyListeners();
  }
}
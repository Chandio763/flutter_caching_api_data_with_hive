import 'dart:convert';

import 'package:flutter_caching_api_data_with_hive/Constants.dart';
import 'package:flutter_caching_api_data_with_hive/model/post.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
class ApiServices{

  static Future<List<UserPost>> getPosts() async {
    //print('Method Called');
    List<UserPost> posts = [];
    Hive.openBox(Constants.APIDATA_BOX);
    try {
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'),);
    if (response.statusCode ==200) {
      print('200');
      Hive.box(Constants.APIDATA_BOX).clear();
      Hive.box(Constants.APIDATA_BOX).put(Constants.API_DATA, jsonDecode(response.body) );
    }
    var listMaps = Hive.box(Constants.APIDATA_BOX).get(Constants.API_DATA);
    //var listMaps = jsonDecode(response.body);
      print(listMaps);
      for (var item in listMaps) {
        posts.add(UserPost.fromMap(item));
      }
      
    } catch (e) {
      //print('object');
    }
  //print(posts.length);
  return posts;
  }
}
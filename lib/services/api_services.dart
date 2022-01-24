// ignore_for_file: avoid_print

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
      //print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      Hive.box(Constants.APIDATA_BOX).clear();
      Hive.box(Constants.APIDATA_BOX).put(Constants.API_DATA,jsonDecode(response.body));
      
    }
    } catch (e) {
      print('object');
    }
    var listMaps =await Hive.box(Constants.APIDATA_BOX).get(Constants.API_DATA, defaultValue: []);
    listMaps.map<UserPost>((map) {
          print(map);
          posts.add(UserPost.fromMap(map));
          return UserPost.fromMap(map);
      }).toList();
    //print('data from hive $listMaps');
    // for (var item in listMaps) {
    //     posts.add(UserPost.fromMap(item));
    //     print('item Added to Post $item');
    // }
  print(posts.length);
  return posts;
  }
}
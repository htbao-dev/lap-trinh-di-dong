import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp4 extends StatelessWidget {
  const MyApp4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageApp4();
  }
}

class HomePageApp4 extends StatefulWidget {
  const HomePageApp4({Key? key}) : super(key: key);

  @override
  _HomePageApp4State createState() => _HomePageApp4State();
}

class _HomePageApp4State extends State<HomePageApp4> {

  late Future<List<Photo>> lsPhoto;

  @override
  void initState() {
    super.initState();
    lsPhoto = Photo.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lsPhoto,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            var data =snapshot.data as List<Photo>;
            return ListView.builder(itemBuilder: (context, index) {
              Photo p = data[index];
              return ListTile(
                leading: Image.network(p.thumbnailUrl),
                title: Text(p.title),

              );
            },
            itemCount: data.length,);
          }
          else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}

class Photo{
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  static Future<List<Photo>> fetchData() async {
    String url ="https://jsonplaceholder.typicode.com/photos";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result).cast<Map<String, dynamic>>();
      List<Photo> list = [];

      for(var item in jsonData){
        list.add(new Photo(item["albumId"], item["id"], item["title"], item["url"], item["thumbnailUrl"]));
      }
      return list;
    }
    else{
      throw Exception("Lỗi lấy dữ liệu. Chi tiết : ${response.statusCode}");
    }
  }
}
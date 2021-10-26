
import 'dart:convert';

import 'package:http/http.dart' as http;

class Product{
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  const Product({required this.id, required this.title, required this.price, required this.description, required this.category, required this.image, required this.rating, });

  static Future<List<Product>> fetchData() async {
    String url = "https://fakestoreapi.com/products?limit=100";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result).cast<Map<String, dynamic>>();
      List<Product> list = [];
      for (var item in jsonData){
        Rating rating = Rating(rate: double.parse(item["rating"]["rate"].toString()), count: item["rating"]["count"]);
        list.add(Product(id: item["id"], title: item["title"], price: double.parse(item["price"].toString()) , description: item["description"], category: item["category"], image: item["image"], rating: rating));
      }
      return list;
    }
    else {
      throw Exception("Lỗi lấy dữ liệu. Chi tiết : ${response.statusCode}");
    }
  }
}

class Rating{
  final double rate;
  final int count;

  const Rating({required this.rate, required this.count});
}
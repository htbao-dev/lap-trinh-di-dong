import 'package:flutter/material.dart';
import 'package:learn_flutter/bt_fetch_api/my_app.dart';
import 'package:learn_flutter/form_basic.dart';
import 'package:learn_flutter/material_basic.dart';

void main() {
  runApp(MyApp6());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Container(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _createRow(_header()),
                    _createRow(_details()),
                    _createRow(_rating()),
                    _createRow(_info())
                  ],
                ))),
      ),
    );
  }

  Widget _createRow(Widget content) {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.blue[50], border: Border.all()),
        child: content);
  }

  Widget _header(){
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Strawberry Pavlova",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget _details(){
    return Text(
      'Pavlova is a meringue-based dessert named after the Russian ballerine Anna Pavlova. \n'
          'Pavlova features a crisp crust and soft, light inside, topped with fruit and whipped cream.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    );
  }

  Widget _rating(){
    var star = Icon(Icons.star, color: Colors.black, size: 18,);
    var starRating = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          star,
          star,
          star,
          star,
          star,
        ]);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        starRating,
        Text("170 Reviews")
      ],
    );
  }

  Widget _info(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _info_item(Icons.kitchen, "PREP:", "25 min"),
          _info_item(Icons.timer, "COOK:", "1 hr"),
          _info_item(Icons.restaurant, "FEEDS:", "4-6")
        ],
      ),
    );
  }

  Widget _info_item(IconData iconData, String name, String info){
    return Column(
      children: [
        Icon(iconData, color: Colors.greenAccent,),
        Text(name),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(info),
        )
      ],
    );
  }
}

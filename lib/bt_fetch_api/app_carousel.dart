import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/bt_fetch_api/product.dart';

class CarouselApp extends StatelessWidget {
  const CarouselApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> lsProduct;
  @override
  void initState() {
    lsProduct = Product.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.brown,
      // appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: lsProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              var data = snapshot.data as List<Product>;
              return CarouselSlider.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                    itemBuilder(data[itemIndex]),
                options: CarouselOptions(
                  height: 500,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  // onPageChanged: callbackFunction,
                  // scrollDirection: Axis.horizontal,
                ),
              );
            }
            else{
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
  
  Widget itemBuilder(Product product){
    return SizedBox(
      width: 420,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          width: 0.1
        )),
        shadowColor: Colors.black,
        // color: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: Column(
            children: [
              SizedBox(height: 15,),
              Image.network(product.image, height: 150, width: 150,),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Text(
                  product.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ratingBuilder(product.rating.rate),
              // SizedBox(height: 5,),
              Text("${product.price} \$",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  fontSize: 20
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Mua"),
                      Icon(Icons.shopping_cart),
                    ],
                  ),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DiaLogContent(),
                            ),
                          );
                        }
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget ratingBuilder(double rating){
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++){
      stars.add
        (Icon(i < rating?Icons.star:Icons.star_border_outlined,
        color: Colors.yellow.shade800,));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }
}

class DiaLogContent extends StatefulWidget {
  const DiaLogContent({Key? key}) : super(key: key);

  @override
  _DiaLogContentState createState() => _DiaLogContentState();
}

class _DiaLogContentState extends State<DiaLogContent> {
  int data = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){
              setState(() {
                if (data > 1){
                  data--;
                }
              });
            }, icon: Icon(Icons.remove),),
            Text(data.toString()),
            IconButton(onPressed: (){
              setState(() {
                data++;
              });
            }, icon: Icon(Icons.add)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Xác nhận")),
      ],
    );
  }
}


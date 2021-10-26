import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_flutter/bt_fetch_api/product.dart';

class MyApp6 extends StatelessWidget {
  const MyApp6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> lsProduct;
  @override
  void initState() {
    lsProduct = Product.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: ,
      ),
        body: FutureBuilder(
          future: lsProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              var data = snapshot.data as List<Product>;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10
                ),
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {
                    Product p = data[index];
                    return gridViewItemBuilder(p);
                  },
                ),
              );
            }
            else{
              return CircularProgressIndicator();
            }
          },
       ),
      );
  }

  Widget gridViewItemBuilder(Product product) {
    return Card(
        child: Column(
          children: [
            SizedBox(height: 15,),
            SizedBox(
              height: 80,
              child: Image.network(product.image),
            ),
            SizedBox(height: 10,),
            Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,

              ),
            ),
            SizedBox(height: 10,),
            Text("Rating: ${product.rating.rate}"),
            // SizedBox(height: 5,),
            Text("${product.price} \$",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(
                bottom: 20
              ),
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(onPressed: (){}, child: Text("Xác nhận")),

                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
              ),
            )

          ],
        ),
      );
    }
}

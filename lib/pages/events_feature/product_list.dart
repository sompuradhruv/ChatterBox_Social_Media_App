import 'package:badges/badges.dart' as badge;
import 'package:chatapp_firebase/pages/profile_feature/pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/events_helper.dart';
import '../../models/cart_model.dart';
import '../../models/item_model.dart';
import '../../provider/events_provider.dart';
import '../../widgets/widgets.dart';
import 'cart_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper dbHelper = DBHelper();

  List<Item> products = [
    Item(
        name: 'Night Club', unit: '100', price: 20, image: 'assets/images/nc.png'),
    Item(
        name: 'Yoga Day',
        unit: '40',
        price: 30,
        image: 'assets/images/y.png'),
    Item(
        name: 'Hackathon',
        unit: '25',
        price: 10,
        image: 'assets/images/h.jpg'),
    Item(
        name: 'Martial Arts',
        unit: '60',
        price: 8,
        image: 'assets/images/ma.png'),
    Item(
        name: 'Birthday Party',
        unit: '50',
        price: 2,
        image: 'assets/images/bp.png'),
    Item(
        name: 'Friendship Day',
        unit: '500',
        price: 5,
        image: 'assets/images/fd.png'),
    Item(
        name: 'Beach Volleyball',
        unit: '24',
        price: 11,
        image: 'assets/images/bv.png'),
    Item(
        name: 'Cricket Match',
        unit: '20000',
        price: 50,
        image: 'assets/images/vk.png'),
  ];

  //List<bool> clicked = List.generate(10, (index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: products[index].name,
          initialPrice: products[index].price,
          productPrice: products[index].price,
          quantity: ValueNotifier(1),
          unitTag: products[index].unit,
          image: products[index].image,
        ),
      )
          .then((value) {
        cart.addTotalPrice(products[index].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFf6a806),
        leading: IconButton(
          onPressed: (){
            nextScreen(context, const Pro());
          }, icon: const Icon(
            Icons.person
        ),
        ),
        centerTitle: true,
        title: const Text('Events List',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27)),
        actions: [
          badge.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const badge.BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image(
                        height: 80,
                        width: 80,
                        image: AssetImage(products[index].image.toString()),
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                  text: 'Name: ',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text:
                                        '${products[index].name.toString()}\n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                  text: 'Members: ',
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text:
                                        '${products[index].unit.toString()}\n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                  text: 'Price: ' r"$",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16.0),
                                  children: [
                                    TextSpan(
                                        text:
                                        '${products[index].price.toString()}\n',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFf6a806),),
                          onPressed: () {
                            saveData(index);
                          },
                          child: const Text('Register Now')),
                    ],
                  ),
                ),
              );
            }),
      );
  }
}

import 'package:chatapp_firebase/pages/events_feature/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/events_provider.dart';

void main() {
  runApp(const pro_main());
}

class pro_main extends StatelessWidget {
  const pro_main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ProductList(),
        );
      }),
    );
  }
}

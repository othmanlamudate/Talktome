// ignore: file_names
import 'package:flutter/material.dart';

import 'package:talktome/Model/product.dart';

import '../../constants/constants.dart';
import '../widgets/ProductCard.dart';
import '../widgets/my_drawer.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  var products = [
    product("1","sub","imge1", 125, false, "description",["fff","ffff"]),
    product("2", "sub","imge2", 0, true, "description",["fff","ffff"]),
    product("3","sub", "imge3", 456, false, "description",["fff","ffff"]),
    product("4","sub", "imge4", 0, true, "description",["fff","ffff"]),
    product("5", "sub","imge5", 184, false, "description",["fff","ffff"]),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF021638)
          : Colors.white,
      drawer: const MyDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
                icon: (Icon(
                  Icons.search_outlined,
                  color: myColor,
                  size: 30,
                )),
                onPressed: () {}),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of objects in each row
              crossAxisSpacing: 10.0, // Spacing between columns
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.9,// Spacing between rows
            ),
            itemCount: 20,
            itemBuilder: (BuildContext ctx, index) {
              return FloatingImageCard();
            }),
      ),
    );
  }
}

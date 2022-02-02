import 'package:eats/models/products.dart';
import 'package:eats/pages/products/products_repository.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  final int idCompany;
  const ProductsPage({Key? key, required this.idCompany}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  body() {
    return FutureBuilder(
        future: ProductsRepository().getTopProductsByCategory(widget.idCompany),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
                height: 50,
                width: 50,
                child: Center(child: CircularProgressIndicator()));
          } else {
            List<Products> products = snapshot.data;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var parse = int.parse(products[index].star!);
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(products[index].image!))),
                      ),
                      Text(products[index].name!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: parse,
                                  itemBuilder: (context, index) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber[700],
                                      size: 12,
                                    );
                                  }),
                            ),
                          ),
                          Text("R\$ ${products[index].value!}")
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}

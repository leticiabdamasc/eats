import 'package:eats/models/carts.dart';
import 'package:eats/pages/cart/cart_repository.dart';
import 'package:eats/pages/details/detals_prod_page.dart';
import 'package:eats/pages/products/products_repository.dart';
import 'package:eats/pages/requests/request_page.dart';
import 'package:eats/utils/nav.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final int idCompany;
  CartPage({Key? key, required this.idCompany}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottom(),
      body: body(),
    );
  }

  body() {
    CartReposiory().getTotal();
    return Column(
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(
              color: Color(0xFFFF8E00),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50))),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
                child: Text(
                  "Carrinho",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
            future: CartReposiory().getCart(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Sem nada por aqui..."));
              } else if (snapshot.data.isEmpty) {
                return Column(
                  children: [Text("Sem nada por aqui...")],
                );
              } else {
                List<Cart> carts = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            push(
                                context,
                                DetailsProdPage(
                                    idProduct: carts[index].idProd!));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 20, top: 20, left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                    future: ProductsRepository()
                                        .getImageById(carts[index].idProd!),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const SizedBox(
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator());
                                      } else {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(snapshot
                                                      .data
                                                      .toString()))),
                                        );
                                      }
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${carts[index].product}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'Quant. ${carts[index].quantity}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20)),
                                              color: Color(0xFFFF8E00)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8,
                                                left: 8,
                                                bottom: 5,
                                                top: 5),
                                            child: Text(
                                              "R\$ ${carts[index].value}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          )),
                                      const SizedBox(height: 20),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.grey[600],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            })
      ],
    );
  }

  bottom() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height / 10,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Total: ",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              FutureBuilder(
                  future: CartReposiory().getTotal(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      value = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'R\$ ${snapshot.data}',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else {
                      return Text('--');
                    }
                  })
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                push(
                    context,
                    RequestPage(
                      value: value,
                      idCompany: widget.idCompany,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Finalizar compra",
                  style: TextStyle(fontSize: 16),
                ),
              ))
        ],
      ),
    );
  }
}

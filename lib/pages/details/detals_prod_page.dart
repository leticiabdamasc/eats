// ignore_for_file: deprecated_member_use

import 'package:eats/models/products.dart';
import 'package:eats/pages/cart/cart_repository.dart';
import 'package:eats/pages/details/details_repository.dart';
import 'package:eats/utils/nav.dart';
import 'package:flutter/material.dart';

class DetailsProdPage extends StatefulWidget {
  final int idProduct;
  DetailsProdPage({Key? key, required this.idProduct}) : super(key: key);

  @override
  State<DetailsProdPage> createState() => _DetailsProdPageState();
}

class _DetailsProdPageState extends State<DetailsProdPage> {
  int _itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: const Color(0xFFFF8E00),
          title: const Text("Detalhes"),
        ),
        body: body(),
      ),
    );
  }

  body() {
    return FutureBuilder(
        future: DetailsRepository().findProductById(widget.idProduct),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Products> prod = snapshot.data;
            return ListView.builder(
                itemCount: prod.length,
                itemBuilder: (context, index) {
                  var parse = int.parse(prod[index].star!);
                  return Column(children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(prod[index].image!))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          prod[index].name!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ ${prod[index].value!}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Classificação",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width / 2,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: parse,
                              itemBuilder: (context, index) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.amber[700],
                                  size: 20,
                                );
                              }),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey[100]),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(prod[index].description!),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Quantidade",
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: <Widget>[
                            _itemCount != 1
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline_rounded,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () =>
                                        setState(() => _itemCount--),
                                  )
                                : Container(),
                            Text(_itemCount.toString()),
                            IconButton(
                                icon: const Icon(
                                    Icons.add_circle_outline_rounded,
                                    color: Colors.green),
                                onPressed: () => setState(() => _itemCount++))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_itemCount >= 1) {
                            var parseDouble = double.parse(prod[index].value!);
                            double total = 0.0;
                            total = parseDouble * _itemCount;
                            int status = await CartReposiory().insertIntoCart(
                                total,
                                _itemCount,
                                prod[index].name!,
                                prod[index].id!);
                            if (status == 1) {
                              final snackBar = SnackBar(
                                content: const Text(
                                    'Produto adicionado ao carrinho!'),
                                duration: const Duration(seconds: 5),
                                action: SnackBarAction(
                                  label: 'Voltar',
                                  onPressed: () {
                                    pop(context);
                                  },
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                content: const Text(
                                    'Produto não adicionado, tente novamente'),
                                duration: const Duration(seconds: 5),
                                action: SnackBarAction(
                                  label: 'Repetir',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 30, top: 10, right: 30, bottom: 10),
                          child: Text(
                            "Adicionar ao carrinho",
                            style: TextStyle(fontSize: 16),
                          ),
                        ))
                  ]);
                });
          }
        });
  }
}

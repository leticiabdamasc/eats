import 'package:eats/pages/cart/cart_repository.dart';
import 'package:eats/pages/home/home_page.dart';
import 'package:eats/pages/requests/request_repository.dart';
import 'package:eats/utils/alert.dart';
import 'package:eats/utils/nav.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  final int idCompany;
  final String value;
  RequestPage({Key? key, required this.value, required this.idCompany})
      : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

TextEditingController nameUser = TextEditingController();
TextEditingController number = TextEditingController();
TextEditingController street = TextEditingController();
TextEditingController district = TextEditingController();
TextEditingController city = TextEditingController();
TextEditingController cep = TextEditingController();

class _RequestPageState extends State<RequestPage> {
  bool debito = false;
  bool credito = false;
  bool dinheiro = false;
  String pay = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  body() {
    return ListView(
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(
              color: Color(0xFFFF8E00),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
                child: Text(
                  "Endereço",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.8,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: ListView(
              children: [
                textFied("Seu nome", nameUser, TextInputType.text),
                textFied("Rua", street, TextInputType.text),
                textFied("N°", number, TextInputType.number),
                textFied("Bairro", district, TextInputType.text),
                textFied("Cidade", city, TextInputType.text),
                textFied("CEP", cep, TextInputType.number),
              ],
            ),
          ),
        ),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text("Formas de pagamento"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            child: Column(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("Débito"),
                    value: debito,
                    onChanged: (val) {
                      setState(() {
                        debito = val!;
                        credito = false;
                        dinheiro = false;
                        pay = 'debito';
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("Crédito"),
                    value: credito,
                    onChanged: (val) {
                      setState(() {
                        credito = val!;
                        debito = false;
                        dinheiro = false;
                        pay = 'credito';
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text("Dinheiro"),
                    value: dinheiro,
                    onChanged: (val) {
                      setState(() {
                        dinheiro = val!;
                        credito = false;
                        debito = false;
                        pay = 'dinheiro';
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () async {
                print("aaaaaaaaaaaaaa");
                var parse = int.parse(number.text);
                var parseCep = int.parse(cep.text);
                var parseValue = double.parse(widget.value);
                int retorno = await RequestRepository().sendRequest(
                    parseValue,
                    nameUser.text,
                    street.text,
                    parse,
                    district.text,
                    city.text,
                    parseCep,
                    pay);
                if (retorno == 1) {
                  print(retorno);
                  pushRemove(context, HomePage(idCompany: widget.idCompany));
                  CartReposiory().clearCart();
                  return alert(context, "Pedido realizado", "", "OK");
                }
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
                child: Text(
                  "Finalizar compra",
                  style: TextStyle(fontSize: 16),
                ),
              )),
        )
      ],
    );
  }

  textFied(String hint, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            keyboardType: type,
            controller: controller,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
            decoration: InputDecoration(
                hintText: hint,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                border: const OutlineInputBorder(),
                labelStyle: const TextStyle(color: Colors.white),
                focusColor: Colors.black,
                fillColor: Colors.black,
                hoverColor: Colors.white,
                hintStyle: const TextStyle(color: Colors.grey)),
          ),
        ),
      ),
    );
  }
}

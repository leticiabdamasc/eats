import 'package:eats/pages/cart/cart_page.dart';
import 'package:eats/pages/categories/category_page.dart';
import 'package:eats/pages/products/products_page.dart';
import 'package:eats/pages/profile/profile_page.dart';
import 'package:eats/pages/requests/request_page.dart';
import 'package:eats/utils/tab_items.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int idCompany;
  const HomePage({Key? key, required this.idCompany}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPosition = 2;
  final PageController _myPage = PageController(initialPage: 2);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavigator(),
        body: pagesView(),
      ),
    );
  }

  body() {
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
                  "Bem - vindo (a)!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Categorias",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 4.3,
          child: CategoryPage(
            idCompany: widget.idCompany,
          ),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18, bottom: 10, top: 10),
              child: Text(
                "Produtos mais vendidos",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        Expanded(
            child: ProductsPage(
          idCompany: widget.idCompany,
        )),
      ],
    );
  }

  bottomNavigator() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BottomAppBar(
        elevation: 0,
        notchMargin: 1.2,
        color: Colors.white,
        // ignore: prefer_const_constructors
        shape: AutomaticNotchedShape(RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabItems(
                text: '',
                icon: Icons.account_circle_outlined,
                isSelected: selectedPosition == 0,
                onTap: () {
                  setState(() {
                    selectedPosition = 0;
                    _myPage.jumpToPage(0);
                  });
                }),
            TabItems(
                text: '',
                icon: Icons.shopping_cart_outlined,
                isSelected: selectedPosition == 1,
                onTap: () {
                  setState(() {
                    selectedPosition = 1;
                    _myPage.jumpToPage(1);
                  });
                }),
            TabItems(
              text: '',
              icon: Icons.home,
              isSelected: selectedPosition == 2,
              onTap: () {
                setState(() {
                  selectedPosition = 2;
                  _myPage.jumpToPage(2);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  pagesView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _myPage,
      onPageChanged: (int) {
        print("Page changes to index $int");
      },
      children: [
        ProfileCompany(idCompany: widget.idCompany),
        CartPage(
          idCompany: widget.idCompany,
        ),
        body(),
      ],
    );
  }
}

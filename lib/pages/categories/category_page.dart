import 'package:eats/models/category.dart';
import 'package:eats/pages/categories/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final int idCompany;
  CategoryPage({Key? key, required this.idCompany}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  body() {
    return FutureBuilder(
        future: CategoryRepository().getCategoryCompany(widget.idCompany),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator());
          } else {
            List<Category> cats = snapshot.data;
            return SizedBox(
              height: 400,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cats.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10, bottom: 5),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 7,
                                width: MediaQuery.of(context).size.height / 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(cats[index].image!))),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, right: 50, top: 5, bottom: 5),
                                child: Text(
                                  cats[index].name!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        });
  }
}

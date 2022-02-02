import 'dart:ui';

import 'package:eats/models/company.dart';
import 'package:eats/pages/home/home_page.dart';
import 'package:eats/pages/intro/intro_repository.dart';
import 'package:eats/utils/nav.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: body()));
  }

  body() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/back.jpg",
          fit: BoxFit.cover,
        ),
        Positioned.fill(
            child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3.0,
              sigmaY: 3.0,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        )),
        const Positioned(
          top: 60,
          left: 155,
          child: Text(
            "EATS",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
            future: IntroRepository().getCompanies(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else {
                List<Company> comp = snapshot.data;
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Selecione o estabelecimento",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: comp.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(
                                          comp[index].image!,
                                        ),
                                      ),
                                      title: Text(comp[index].fantasyName!,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                      trailing: const Icon(
                                        Icons.double_arrow_rounded,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        push(
                                            context,
                                            HomePage(
                                                idCompany: comp[index].id!));
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }
}

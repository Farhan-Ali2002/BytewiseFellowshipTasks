import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Home.dart';

import '../View_model/data_class.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 131, 53, 170),
      body: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Consumer<DataClass>(builder: (context, data, child) {
                        return Text(
                          '${data.shoes}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      }),
                      const Text(
                        "-- Total Shoes",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (Provider.of<DataClass>(context, listen: false)
                                .shoes <=
                            0) {
                          Get.snackbar("Item", "Can not decrease more",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              titleText: const Text(
                                "Item",
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                              messageText: const Text(
                                "Can not reduce more",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ));
                        } else {
                          Provider.of<DataClass>(context, listen: false)
                              .decrementShoe();
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 0, 0, 0))),
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 60,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const HomePage(),
                                transition: Transition.downToUp,
                                duration: const Duration(seconds: 1));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.skip_previous,
                                  color: Color(0xFFfefeff)),
                              Text(
                                "Prev Page",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFFfefeff)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../View_model/data_class.dart';
import 'second_page.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.8,
      decoration: BoxDecoration(color: Colors.amber, border: Border.all()),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Shoes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  Consumer<DataClass>(builder: (context, data, child) {
                    return Text(
                      '${data.shoes}',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    );
                  }),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: GestureDetector(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromARGB(255, 12, 12, 12),
                                width: 1)),
                        child: const Icon(Icons.add),
                      ),
                      onTap: () {
                        if (context.read<DataClass>().shoes >= 5) {
                          Get.snackbar("Item", "Can not more than this",
                              backgroundColor: Colors.black,
                              colorText: Colors.white,
                              titleText: const Text(
                                "Item",
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ),
                              messageText: const Text(
                                "Can not be more than this",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ));
                        } else {
                          context.read<DataClass>().incrementShoe();
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const SecondPage(),
                                    transition: Transition.upToDown,
                                    duration: const Duration(seconds: 1));
                              },
                              child: const Text(
                                "Next Page",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                          const Spacer(),
                          const Icon(Icons.skip_next, color: Colors.white)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

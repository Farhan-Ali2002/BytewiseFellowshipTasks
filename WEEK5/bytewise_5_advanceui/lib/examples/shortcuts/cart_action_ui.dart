import 'package:bytewise_5_advanceui/examples/shortcuts/actions/increment_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  TextEditingController cartController = TextEditingController();

  void changeQuantity(value) {
    value = value.toString();
    cartController.text = value;
  }

  @override
  Widget build(BuildContext context) {
    cartController.text = '0';
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowUp): const incrementIntent(),
      },
      child: Actions(
        actions: {
          incrementIntent: CallbackAction<incrementIntent>(
              onInvoke: ((intent) =>
                  changeQuantity(int.parse(cartController.text) + 1)))
        },
        child: Scaffold(
          body: Column(
            children: [
              Stack(children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(90)),
                      shape: BoxShape.rectangle,
                      color: Colors.blue),
                ),
                Positioned(
                  left: 0,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                const Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Cart",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 60,
              ),
              Focus(
                autofocus: true,
                child: SizedBox(
                  height: 400,
                  width: 300,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Iphone 13 Pro Max',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          child: Image.asset(
                            'assets/images/iphone.jpg',
                            height: 250,
                            width: 300,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          width: 180,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  int num = int.parse(cartController.text);
                                  if (num >= 0) {
                                    num += 1;
                                    cartController.text = num.toString();
                                  }
                                },
                                child: const Text(
                                  "+",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: TextFormField(
                                  controller: cartController,
                                  minLines: 1,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  int num = int.parse(cartController.text);
                                  if (num > 0) {
                                    num -= 1;
                                    cartController.text = num.toString();
                                  }
                                },
                                child: const Text(
                                  "-",
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

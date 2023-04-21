import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographyFonts extends StatefulWidget {
  const TypographyFonts({super.key});

  @override
  State<TypographyFonts> createState() => _TypographyFontsState();
}

class _TypographyFontsState extends State<TypographyFonts> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          textTheme: TextTheme(
              headlineSmall: GoogleFonts.adventPro(),
              bodyMedium: GoogleFonts.abel(fontSize: 20))),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Typography"),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            height: 600,
            width: 450,
            child: Padding(
              padding: const EdgeInsets.all(45.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "I haven't bailed on writing. Look, I'm generating a random paragraph at this very moment in an attempt to get my writing back on track. I am making an effort. I will start writing consistently again",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "a b c d e f g h i j k l m n o p q r s t u v w x y z",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

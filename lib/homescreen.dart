import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String input = "";
  String answer = "";
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = input;
  }

  void handleTap(String text) {
    setState(() {
      input += text;
      controller.text = input;
    });
  }

  void clear() {
    setState(() {
      input = "";
      answer = "";
      controller.text = "";
    });
  }

  void calculate() {
    setState(() {
      try {
        String parser = "";
        if (input.contains("+")) {
          parser = "+";
        } else if (input.contains("-")) {
          parser = "-";
        } else if (input.contains("/")) {
          parser = "/";
        } else if (input.contains("*")) {
          parser = "*";
        } else {
          answer = input;
          controller.text = answer;
          return;
        }

        List<String> parts = input.split(parser);

        if (parts.length < 2) {
          answer = "error";
          controller.text = answer;
          return;
        }

        double result = double.parse(parts[0]);

        for (int i = 1; i < parts.length; i++) {
          double num = double.parse(parts[i]);

          switch (parser) {
            case "+":
              result += num;
              break;
            case "-":
              result -= num;
              break;
            case "*":
              result *= num;
              break;
            case "/":
              if (num == 0) {
                answer = "error";
                controller.text = answer;
                return;
              }
              result /= num;
              break;
          }
        }

        // format the result
        if (result % 1 == 0) {
          answer = result.toInt().toString();
        } else {
          answer = result.toString();
        }

        controller.text = answer;
        input = answer;
      } catch (e) {
        answer = "error";
        controller.text = answer;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 70, 20, 164),
              Color.fromARGB(255, 78, 88, 193),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Container(
            height: 600,
            width: 400,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 215, 222, 226),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      input = value;
                    },
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Buttons(ontap: clear, icon: ("C")),
                        Buttons(ontap: () => handleTap("/"), icon: ("/")),
                        Buttons(ontap: () => handleTap("*"), icon: ("*")),
                        Buttons(ontap: () => handleTap("-"), icon: ("-")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Buttons(ontap: () => handleTap("7"), icon: ("7")),
                        Buttons(ontap: () => handleTap("8"), icon: ("8")),
                        Buttons(ontap: () => handleTap("9"), icon: ("9")),
                        Buttons(ontap: () => handleTap("+"), icon: ("+")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Buttons(ontap: () => handleTap("4"), icon: ("4")),
                        Buttons(ontap: () => handleTap("5"), icon: ("5")),
                        Buttons(ontap: () => handleTap("6"), icon: ("6")),
                        Buttons(ontap: calculate, icon: ("=")),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Buttons(ontap: () => handleTap("1"), icon: ("1")),
                        Buttons(ontap: () => handleTap("2"), icon: ("2")),
                        Buttons(ontap: () => handleTap("3"), icon: ("3")),
                        Buttons(ontap: () => handleTap("0"), icon: ("0")),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

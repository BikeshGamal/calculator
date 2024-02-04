import 'package:calculator_h/caluculator_button.dart';
import 'package:calculator_h/custom_theme.dart';
import 'package:calculator_h/global.dart';
import 'package:calculator_h/menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int c = 0;

  List<Menu> _buttonList = [
    Menu(label: "AC", color: CustomTheme.orangeColor),
    Menu(label: Icons.backspace_outlined, color: CustomTheme.orangeColor),
    Menu(label: "%", color: CustomTheme.orangeColor),
    Menu(label: "/", color: CustomTheme.orangeColor),
    Menu(label: "7", color: Colors.white),
    Menu(label: "8", color: Colors.white),
    Menu(label: "9", color: Colors.white),
    Menu(label: "*", color: CustomTheme.orangeColor),
    Menu(label: "4", color: Colors.white),
    Menu(label: "5", color: Colors.white),
    Menu(label: "6", color: Colors.white),
    Menu(label: "-", color: CustomTheme.orangeColor),
    Menu(label: "1", color: Colors.white),
    Menu(label: "2", color: Colors.white),
    Menu(label: "3", color: Colors.white),
    Menu(label: "+", color: CustomTheme.orangeColor),
  ];
  @override
  Widget build(BuildContext context) {
    print(expression);
    return Scaffold(
        backgroundColor: CustomTheme.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Calculator App",
            style: GoogleFonts.pacifico(
                color: CustomTheme.orangeColor,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: CustomTheme.primaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12,left: 12),
              child: Container(
                height: MediaQuery.of(context).size.height*0.1,
                child: Text(
                  expression,
                  style: TextStyle(
                      color: CustomTheme.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                output,
                style: TextStyle(
                    color: CustomTheme.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CalculatorButton(
                  label: _buttonList[index].label == "/"
                      ? "÷"
                      : _buttonList[index].label,
                  textColor: _buttonList[index].color,
                  onPressed: () {
                    setState(() {
                      if (_buttonList[index].label == "AC") {
                        expression = "";
                        output = "";
                      } else if (_buttonList[index].label is IconData) {
                        expression.length >= 1
                            ? expression =
                                expression.substring(0, expression.length - 1)
                            : expression = "";
                      } else if (_buttonList[index].label == "") {
                        expression = "";
                      } else {
                        expression = expression + _buttonList[index].label;
                      }
                    });
                  },
                );
              },
              itemCount: _buttonList.length,
            ),
            Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                CalculatorButton(
                  label: "0",
                  textColor: CustomTheme.white,
                  onPressed: () {
                    setState(() {
                      expression = expression + "0";
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                CalculatorButton(
                  label: ".",
                  textColor: CustomTheme.white,
                  onPressed: () {
                    setState(() {
                      c == 0 ? expression = expression + "." : expression;
                      c++;
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                CalculatorButton(
                  label: "=",
                  textColor: CustomTheme.white,
                  width: 168,
                  onPressed: () {
                    setState(() {
                      try {
                        Parser p = Parser();
                        Expression exp = p.parse(expression);
                        ContextModel cm = ContextModel();
                        output = "${exp.evaluate(EvaluationType.REAL, cm)}";
                      } catch (e) {
                      Fluttertoast.showToast(msg: "invalid expression");
                      }
                      ;
                    });
                  },
                  //onPressed: buttonPressed("="),
                )
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ));
  }
}

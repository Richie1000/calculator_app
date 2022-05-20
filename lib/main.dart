import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //var screenSize = MediaQuery.of(context).size;
    return const MaterialApp(
      title: "Calculator",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final List<String> buttonPressed = [];
  String userExpression = "";
  String answer = '';

  bool isOperator(String input) {
    if (input == '/' ||
        input == 'x' ||
        input == '-' ||
        input == '+' ||
        input == '=') {
      return true;
    }
    return false;
  }

  String displaytext() {
    if (answer == "") {
      return userExpression;
    }
    return answer;
  }

  void buttonTapped(String text) {
    setState(() {
      userExpression += text;
    });
  }

  void equalTo() {
    setState(() {
      String finalExpression = userExpression;
      finalExpression = userExpression.replaceAll("x", "*");
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      answer = result.toString();
      userExpression = '';
    });
  }

  Widget numberButton(String number) {
    return ElevatedButton(
      onPressed: () {
        answer = '';
        buttonTapped(number);
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.white60,
          fixedSize: const Size(300, 300),
          shape: const CircleBorder()),
      child: Text(
        number,
        style: const TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }

  Widget otherButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          answer = '';
          userExpression = '';
        });
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.lightGreen,
          fixedSize: const Size(200, 200),
          shape: const CircleBorder()),
      child: const Text(
        "AC",
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }

  Widget operatorButton(String btText) {
    return ElevatedButton(
      onPressed: () {
        buttonTapped(btText);
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          fixedSize: const Size(200, 200),
          shape: const CircleBorder()),
      child: Text(
        btText,
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }

  Widget functionButton(String btText) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          buttonTapped(btText);
        },
        child: Center(
          child: Text(
            btText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  Widget dotButton() {
    return ElevatedButton(
      onPressed: () {
        buttonTapped(".");
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.white60,
          fixedSize: const Size(200, 200),
          shape: const CircleBorder()),
      child: Text(
        ".",
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }

  Widget deletebutton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            userExpression =
                userExpression.substring(0, userExpression.length - 1);
          });
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.white60,
            fixedSize: const Size(200, 200),
            shape: const CircleBorder()),
        child: Icon(
          Icons.backspace_outlined,
          size: 25,
          color: Colors.black,
        ));
  }

  Widget equalsButton() {
    return ElevatedButton(
      onPressed: () {
        equalTo();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey,
          fixedSize: const Size(200, 200),
          shape: const CircleBorder()),
      child: const Text(
        "=",
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var screenSize = MediaQuery.of(context).size;
    final customAppBar = AppBar(
      title: const Text("Calculator"),
    );
    return Scaffold(
      appBar: customAppBar,
      body: Column(
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                    customAppBar.preferredSize.height) *
                0.28,
            child: Container(
              color: Colors.white,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  displaytext(),
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                    customAppBar.preferredSize.height) *
                0.67,
            child: GridView(
                children: [
                  functionButton("√"),
                  functionButton("π"),
                  functionButton("π"),
                  functionButton("^"),
                  otherButton(),
                  operatorButton("("),
                  operatorButton(")"),
                  operatorButton("/"),
                  numberButton("7"),
                  numberButton("8"),
                  numberButton("9"),
                  operatorButton("x"),
                  numberButton("4"),
                  numberButton("5"),
                  numberButton("6"),
                  operatorButton("-"),
                  numberButton("3"),
                  numberButton("2"),
                  numberButton("1"),
                  operatorButton("+"),
                  numberButton("0"),
                  dotButton(),
                  deletebutton(),
                  equalsButton(),
                ],
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 0.1)),
          )
        ],
      ),
    );
  }
}

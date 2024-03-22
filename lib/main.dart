import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = "";
  String _operand1 = '';
  String _operand2 = '';
  String _operation = '';
  void calculate(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
        _operand1 = '';
        _operand2 = '';
        _operation = '';
      } else if (buttonText == '=') {
        if (_operand1 != '' && _operand2 != '' && _operation != '') {
          num result = 0;
          num num1 = num.parse(_operand1);
          num num2 = num.parse(_operand2);
          switch (_operation) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case 'X':
              result = num1 * num2;
              break;
            case '/':
              if (num2 != 0) {
                result = num1 / num2;
              } else {
                _output = "Error";
              }
              break;
          }
          if (_output != 'Error') {
            _output = result.toStringAsFixed(6);
            _operand1 = '';
            _operand2 = '';
            _operation = '';
          } else {
            _output = 'Error';
          }
        }
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == 'X' ||
          buttonText == '/') {
        if (_operand1 != '' && _operand2 == '') {
          _operation = buttonText;
          _output += buttonText;
        }
      } else {
        if (_operation == '') {
          _operand1 += buttonText;
          _output += buttonText;
        } else {
          _operand2 += buttonText;
          _output += buttonText;
        }
      }
    });
  }

  void handlebackspace() {
    setState(() {
      if (_output != '') {
        _output = _output.substring(0, _output.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            title: Text(widget.title),
            titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 24,
            )),
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                _output,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () => handlebackspace(),
                  icon: const Icon(Icons.backspace),
                  iconSize: 30,
                ),
              ),
            ]),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons("C"),
                buttons("( )"),
                buttons("%"),
                buttons("/"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons("7"),
                buttons("8"),
                buttons("9"),
                buttons("X"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons("4"),
                buttons("5"),
                buttons("6"),
                buttons("-"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons("1"),
                buttons("2"),
                buttons("3"),
                buttons("+"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttons("."),
                buttons("0"),
                buttons("."),
                buttons("="),
              ],
            ),
            const SizedBox(height: 20),
          ])
        ]));
  }

  ElevatedButton buttons(String text) {
    return ElevatedButton(
      onPressed: () => calculate(text),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black54),
        minimumSize: MaterialStateProperty.all(const Size(70, 70)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 27,
        ),
      ),
    );
  }
}

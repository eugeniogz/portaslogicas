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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Portas Lógicas'),
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
  bool out = false;
  bool a = false;
  bool b = false;
  Porta p = Porta.xor;
  void setOutput(int input) {
    setState(() {
      if (input == 1) {
        a = !a;
      } else {
        b = !b;
      }
      if (p.name == "xor") {
        out = a ^ b;
      } else if (p.name == "or") {
        out = a || b;
      } else if (p.name == "and") {
        out = a && b;
      } else if (p.name == "not") {
        out = !a;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the setOutput method above.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                setOutput(1);
              },
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => a ? Colors.amber : Colors.grey ) ),
              child: const Text("A"),
            ),
            TextButton(
              onPressed: () {
                setOutput(2);
              },
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => b ? Colors.amber : Colors.grey ) ),
              child: const Text("B"),
            ),
            Icon(
              Icons.baby_changing_station,
              color: out ? Colors.amber : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

enum Porta { not, and, or, xor }

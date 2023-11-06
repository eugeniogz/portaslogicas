import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portas Lógicas',
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
  bool out = true;
  bool a = false;
  bool b = false;
  Porta p = Porta.not;
  void setPorta(Porta p) {
    setState(() {
      this.p = p;
      setarOut();
    });
  }

  void setOutput(int input) {
    setState(() {
      if (input == 1) {
        a = !a;
      } else {
        b = !b;
      }
      setarOut();
    });
  }

  void setarOut() {
    if (p == Porta.nxor) {
      out = !(a ^ b);
    } else if (p == Porta.or) {
      out = a || b;
    } else if (p == Porta.and) {
      out = a && b;
    } else if (p == Porta.not) {
      out = !a;
      b = false;
    }
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              BotaoPorta(
                  title: "NÃO",
                  porta: Porta.not,
                  portaAtual: p,
                  setPorta: setPorta),
              BotaoPorta(
                  title: "OU",
                  porta: Porta.or,
                  portaAtual: p,
                  setPorta: setPorta),
              BotaoPorta(
                  title: "E",
                  porta: Porta.and,
                  portaAtual: p,
                  setPorta: setPorta),
              BotaoPorta(
                  title: "IGUAL",
                  porta: Porta.nxor,
                  portaAtual: p,
                  setPorta: setPorta),
            ]),
            const Text(""),
            GestureDetector(
                // //Opção para alterar o estado somente quando pressionar e voltar quando soltar
                // onTapDown: (TapDownDetails? td) {setOutput(1);},
                // onTapCancel: () {setOutput(1);},
                child: TextButton(
              onPressed: () {
                setOutput(1);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => a ? Colors.amber : Colors.grey)),
              child: Icon(a ? Icons.thumb_up : Icons.thumb_down),
            )),
            const Text(""),
            p != Porta.not
                ? TextButton(
                    onPressed: () {
                      setOutput(2);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => b ? Colors.amber : Colors.grey)),
                    child: Icon(b ? Icons.thumb_up : Icons.thumb_down),
                  )
                : const Text(""),
            const Text(""),
            Icon(
              out ? Icons.thumb_up : Icons.thumb_down,
              color: out ? Colors.amber : Colors.grey,
            ),
          ],
        ));
  }
}

class BotaoPorta extends StatelessWidget {
  final Porta porta;
  final Porta portaAtual;
  final Function setPorta;
  final String title;

  const BotaoPorta(
      {super.key,
      required this.title,
      required this.porta,
      required this.portaAtual,
      required this.setPorta});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      TextButton(
          onPressed: () {
            setPorta(porta);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith((states) =>
                  portaAtual == porta
                      ? Colors.deepPurple.shade100
                      : Colors.grey)),
          child: Text(title)),
      const Text(" ")
    ]);
  }
}

enum Porta { not, and, or, nxor }

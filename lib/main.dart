import 'package:eazypercent/Percent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Eazypercent'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final partText = TextEditingController();
  final percentText = TextEditingController();
  final totalText = TextEditingController();

  void calculate() {
    if ((partText.text == '' && percentText.text == '') ||
        (partText.text == '' && totalText.text == '') ||
        (totalText.text == '' && percentText.text == '')) {
      return;
    }
    //Calculate the total
    if ((partText.text != '' && percentText.text != '') &&
        totalText.text == '') {
      totalText.text = Percent.getTotal(
              double.parse(percentText.text), double.parse(partText.text))
          .toString();
      partText.text = '';
      percentText.text = '';
    }
    //Calculate the part
    if ((partText.text == '' && percentText.text != '') &&
        totalText.text != '') {
      partText.text = Percent.getPart(
              double.parse(totalText.text), double.parse(percentText.text))
          .toString();
      totalText.text = '';
      percentText.text = '';
    }
    //Calculate the percent
    if ((partText.text != '' && percentText.text == '') &&
        totalText.text != '') {
      percentText.text = Percent.getPercent(
              double.parse(totalText.text), double.parse(partText.text))
          .toString();
      totalText.text = '';
      partText.text = '';
    }
  }

  void changeState() {
    setState(() {
      calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    children: [
                      Text(
                        'Como Usar',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Introduce datos en dos de los campos, luego presiona calcular y el campo en blanco sera calculado.',
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 17, color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: partText,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(labelText: 'Parte'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: percentText,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(labelText: 'Porciento'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: totalText,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(labelText: 'Total'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      changeState();
                    },
                    icon: Icon(
                      Icons.calculate,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    label: Text('Calcular'),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 56, vertical: 15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

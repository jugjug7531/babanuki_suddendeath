import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ババ抜きサドンデスクイズ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ババ抜きサドンデスクイズ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  // 選択肢カード
  List<Map<String, String>> choices = [
    {
      "choice": "夜に駆ける",
      "answer": "true"
    },
    {
      "choice": "おっぱい",
      "answer": "true"
    },
    {
      "choice": "ナンプラー\n日和",
      "answer": "true"
    },
    {
      "choice": "1987→",
      "answer": "true"
    },
    {
      "choice": "孫悟空",
      "answer": "true"
    },
    {
      "choice": "トンボ\n飛べなかった",
      "answer": "false"
    }
  ];

  // カードを並べた時の全体の横幅
  double _cardInterval = 200;
  // カードの横幅
  double _cardWidth = 150;
  // カードの縦幅
  double _cardHeight = 200;


  // 選択肢カードWidget作成
  Widget createChoiceWidget(String? choice, String? answer){
    if(choice == null){
      print("[ERROR] choice is null");
      choice = 'null';
    }
    if(answer == null){
      print("[ERROR] answer is null");
      answer = 'true';
    }
    return SizedBox(
      width: _cardWidth,
      height: _cardHeight,
      child:Card(
        elevation: 0.0,
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
        color: Color(0x00000000),
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 1000,
          onFlipDone: (status) {
            print(status);
          },
          front: Container(
            decoration: BoxDecoration(
              color: Color(0x000000),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  choice,  //選択肢
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
              color: Color(0x000000),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  answer,  //答え
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /* 問題文 */
            Text(
              "スピッツの曲を選べ（１つは不正解）",
              style: TextStyle(
                fontFamily: 'Kosugi',
                fontSize: 40,
                backgroundColor: Colors.amberAccent,
              ),
            ),
            /* 6つの選択肢を表にして表示する */
            Table(
              defaultColumnWidth: FixedColumnWidth(_cardInterval),
              children:<TableRow>[
                TableRow(
                  children: <Widget>[
                    createChoiceWidget(choices[0]["choice"], choices[0]["answer"]),
                    createChoiceWidget(choices[1]["choice"], choices[1]["answer"]),
                    createChoiceWidget(choices[2]["choice"], choices[2]["answer"]),
                  ]
                ),
                TableRow(
                  children: <Widget>[
                    createChoiceWidget(choices[3]["choice"], choices[3]["answer"]),
                    createChoiceWidget(choices[4]["choice"], choices[4]["answer"]),
                    createChoiceWidget(choices[5]["choice"], choices[5]["answer"]),
                  ]
                )
              ]
            )
          ]
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';

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

  // カードを並べた時の横の間隔
  double _cardInterval = 200;

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
    return GestureDetector(
            onTap: () {
              if(answer == "true"){
                print("正解！！");
              }else if(answer == "false"){
                print("ドボン！！！！！！");
              }
            },
            child:Stack( //重ねる
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Text(
                    choice,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ]
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
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              defaultColumnWidth: FixedColumnWidth(_cardInterval), // カードの横幅を指定
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

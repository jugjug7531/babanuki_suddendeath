import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

/**
 * ドボンクイズの基底クラス
 */
class QuizBase extends StatelessWidget {

  // ルーティングのパス(override必須)
  static const path = '';

  // 問題文(override必須)
  String question = "";

  // 選択肢カード(override必須)
  List<Map<String, String>> choices = [];


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
            //todo:効果音追加、ドボン時のエフェクト
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
  //Widget build(BuildContext context, String question, List<Map<String, String>> choices) {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("問題"),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /* 問題文 */
            Text(
              question,
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
            ),
            /* タイトル画面に戻るボタン */
            TextButton(
              child: Text("問題選択ページに戻る"),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ]
        ),
      ),
    );
  }
}
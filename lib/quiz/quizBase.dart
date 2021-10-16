import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:audioplayers/audioplayers.dart';

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
  //正解カードの背景画像パス
  String _correct_image = 'assets/images/correct.png';
  //不正解カードの背景画像パス
  String _wrong_image = 'assets/images/wrong.png';
  //正解時の効果音
  String _correct_bgm = 'sounds/correct.mp3';
  //不正解時の効果音
  String _wrong_bgm = 'sounds/wrong.mp3';

  // 作成したカードの枚数をカウント
  int _cardNumCount = 0;
  // カード裏面の選択肢の文字色
  Color _backside_choice_color = Colors.black;
  // 正誤画像のパス
  String _judge_image = "";

  // 選択肢カードWidget作成
  //Widget createChoiceWidget(String? choice, String? answer){
  Widget createChoiceWidget(Map<String, String> quiz){

    String choice = quiz["choice"].toString();
    String answer = quiz["answer"].toString();
    String explanation = quiz["explanation"].toString();

    // AudioCacheインスタンスの初期化
    AudioCache _player = AudioCache();

    //作成したカードの枚数をカウント
    _cardNumCount++;

    //正解・不正解に応じて裏面のデザインを変更
    if(answer == "true"){
      _backside_choice_color = Colors.red;
      _judge_image = _correct_image;
    }else{
      _backside_choice_color = Colors.blue;
      _judge_image = _wrong_image;
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
            //裏面のとき
            if(status){
              //正誤判定の効果音を鳴らす
              if(answer == "true"){
                _player.play(_correct_bgm);
              }else if(answer == "false"){
                _player.play(_wrong_bgm);
              }
            }
          },
          //カード表面
          front: Container(
            decoration: BoxDecoration(
              color: Color(0x000000),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Stack(
              children: <Widget>[ 
                //選択肢
                Center(
                  child:Text(
                        choice,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                ),
                //カード番号
                Text(
                  _cardNumCount.toString(),  
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          //カード裏面
          back: Container(
            decoration: BoxDecoration(
              color: Color(0x000000),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Stack(
              children: <Widget>[
                //背景画像
                Image(
                  image: AssetImage(_judge_image),
                  // fit: BoxFit.cover,
                ),
                //文字
                Center(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //選択肢
                      Text(
                        choice,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _backside_choice_color,
                        ),
                      ),
                      //解説
                      Text(
                        explanation,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  )
                ),
                //カード番号
                Text(
                  _cardNumCount.toString(),  
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
                    createChoiceWidget(choices[0]),
                    createChoiceWidget(choices[1]),
                    createChoiceWidget(choices[2]),
                  ]
                ),
                TableRow(
                  children: <Widget>[
                    createChoiceWidget(choices[3]),
                    createChoiceWidget(choices[4]),
                    createChoiceWidget(choices[5]),
                  ]
                )
              ]
            ),
            /* タイトル画面に戻るボタン */
            Padding(
              padding: EdgeInsets.all(30),
              child: ElevatedButton(
                child: const Text('問題選択ページに戻る'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}
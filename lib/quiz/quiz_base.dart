import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:audioplayers/audioplayers.dart';

import '../question.dart';

/// ドボンクイズの基底クラス

class QuizBase extends StatelessWidget {
  QuizBase({Key? key}) : super(key: key);

  /// ルーティングのパス
  static const String path = '/question';

  /// 問題文
  final String question = "";

  /// 選択肢カード
  final List<Map<String, String>> choices = [];


  /// カードを並べた時の全体の横幅
  final double _cardInterval = 200;
  /// カードの横幅
  final double _cardWidth = 150;
  /// カードの縦幅
  final double _cardHeight = 200;
  /// 正解カードの背景画像パス
  static const String correctImage = 'assets/images/correct.png';
  /// 不正解カードの背景画像パス
  static const String wrongImage = 'assets/images/wrong.png';
  /// 正解時の効果音
  static const String correctBgm = 'sounds/correct.mp3';
  /// 不正解時の効果音
  static const String wrongBgm = 'sounds/wrong.mp3';

  /// 
  String getPath(){
    return path;
  }

  /// 選択肢カードWidget作成
  Widget createChoiceWidget(Choice choice, int cardNumCount){

    /// カード裏面の選択肢の文字色
    Color _backsideChoiceColor = Colors.black;
    /// 正誤画像のパス
    String _judgeImage = "";

    /// AudioCacheインスタンスの初期化
    AudioCache _player = AudioCache();

    // 作成したカードの枚数をカウント
    cardNumCount++;

    // 正解・不正解に応じて裏面のデザインを変更
    if(choice.answer == "true"){
      _backsideChoiceColor = Colors.red;
      _judgeImage = correctImage;
    }else{
      _backsideChoiceColor = Colors.blue;
      _judgeImage = wrongImage;
    }

    return SizedBox(
      width: _cardWidth,
      height: _cardHeight,
      child:Card(
        elevation: 0.0,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
        color: const Color(0x00000000),
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 1000,
          onFlipDone: (status) {
            // 裏面のとき
            if(status){
              // 正誤判定の効果音を鳴らす
              if(choice.answer == "true"){
                _player.play(correctBgm);
              }else if(choice.answer == "false"){
                _player.play(wrongBgm);
              }
            }
          },
          // カード表面
          front: Container(
            decoration: BoxDecoration(
              color: const Color(0x00000000),
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Stack(
              children: <Widget>[ 
                // 選択肢
                Center(
                  child:Text(
                        choice.choice,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                ),
                // カード番号
                Text(
                  cardNumCount.toString(),  
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          // カード裏面
          back: Container(
            decoration: BoxDecoration(
              color: const Color(0x00000000),
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Stack(
              children: <Widget>[
                // 背景画像
                Center(
                  child:Image(
                    image: AssetImage(_judgeImage),
                  )
                ),
                // 文字
                Center(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // 選択肢
                      Text(
                        choice.choice,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _backsideChoiceColor,
                        ),
                      ),
                      // 解説
                      Text(
                        choice.explanation,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  )
                ),
                // カード番号
                Text(
                  cardNumCount.toString(),  
                  style: const TextStyle(
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
    // `ModalRoute.of()`メソッドを使用してページ遷移時の引数を取得
    final args = ModalRoute.of(context)!.settings.arguments as Question;

    return Scaffold(
      appBar: AppBar(
        title: const Text("問題"),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 問題文
            Text(
              args.problemStatement,
              style: const TextStyle(
                fontFamily: 'Kosugi',
                fontSize: 40,
                backgroundColor: Colors.amberAccent,
              ),
            ),
            // 6つの選択肢を表にして表示する
            Table(
              defaultColumnWidth: FixedColumnWidth(_cardInterval),
              children:<TableRow>[
                TableRow(
                  children: <Widget>[
                    createChoiceWidget(args.choices[0], 0),
                    createChoiceWidget(args.choices[1], 1),
                    createChoiceWidget(args.choices[2], 2),
                  ]
                ),
                TableRow(
                  children: <Widget>[
                    createChoiceWidget(args.choices[3], 3),
                    createChoiceWidget(args.choices[4], 4),
                    createChoiceWidget(args.choices[5], 5),
                  ]
                )
              ]
            ),
            const SizedBox(height: 30),
            // タイトル画面に戻るボタン
            ElevatedButton(
              child: const Text('問題選択ページに戻る'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]
        ),
      ),
    );
  }
}
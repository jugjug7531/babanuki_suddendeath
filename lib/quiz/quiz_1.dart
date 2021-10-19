import 'package:flutter/material.dart';
import 'quiz_base.dart';

///
/// 1問目のドボン問題クラス
///
/// オーバーライド必須
/// - [path] ルーティングパス 
/// - [question] 問題文 
/// - [choices] 選択肢カード

class Quiz1 extends QuizBase {
  Quiz1({Key? key}) : super(key: key);

  /// ルーティングのパス
  static const String path = '/1';

  /// 問題文
  final String question = "東北地方の県を選べ（１つは不正解）";

  /// 選択肢カード
  final List<Map<String, String>> choices = [
    {
      "choice": "青森県",
      "explanation" : "リンゴ有名",
      "answer": "true"
    },
    {
      "choice": "秋田県",
      "explanation" : "きりたんぽ有名",
      "answer": "true"
    },
    {
      "choice": "宮崎県",
      "explanation" : "九州地方です",
      "answer": "false"
    },
    {
      "choice": "岩手県",
      "explanation" : "わんこそば有名",
      "answer": "true"
    },
    {
      "choice": "山形県",
      "explanation" : "果物有名",
      "answer": "true"
    },
    {
      "choice": "福島県",
      "explanation" : "喜多方ラーメン有名",
      "answer": "true"
    }
  ];

  ///
  @override 
  String getPath(){
    return path;
  }
}
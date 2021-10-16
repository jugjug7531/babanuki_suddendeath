import 'package:flutter/material.dart';
import 'quizBase.dart';

/**
 * 1問目のドボン問題クラス
 */
class Quiz1 extends QuizBase {

  @override
  // ルーティングのパス
  static const path = '/1';

  @override
  // 問題文
  String question = "東北地方の県を選べ（１つは不正解）";

  @override
  // 選択肢カード
  List<Map<String, String>> choices = [
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
      "choice": "山梨県",
      "explanation" : "果物有名",
      "answer": "true"
    },
    {
      "choice": "福島県",
      "explanation" : "喜多方ラーメン有名",
      "answer": "true"
    }
  ];
}
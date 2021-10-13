import 'package:flutter/material.dart';
import 'quizBase.dart';

/**
 * 1問目のドボン問題クラス
 */
class Quiz1 extends QuizBase {

  Quiz1();

  @override
  // 問題文
  String question = "東北地方の県を選べ（１つは不正解）";

  @override
  // 選択肢カード
  List<Map<String, String>> choices = [
    {
      "choice": "青森県",
      "answer": "true"
    },
    {
      "choice": "秋田県",
      "answer": "true"
    },
    {
      "choice": "宮崎県",
      "answer": "false"
    },
    {
      "choice": "岩手県",
      "answer": "true"
    },
    {
      "choice": "山梨県",
      "answer": "true"
    },
    {
      "choice": "福島県",
      "answer": "true"
    }
  ];
}
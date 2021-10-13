import 'package:flutter/material.dart';
import 'quizBase.dart';

/**
 * 2問目のドボン問題クラス
 */
class Quiz2 extends QuizBase {

  @override
  // 問題文
  String question = "スピッツの曲を選べ（１つは不正解）";

  @override
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
}
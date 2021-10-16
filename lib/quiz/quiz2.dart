import 'package:flutter/material.dart';
import 'quizBase.dart';

/**
 * 2問目のドボン問題クラス
 */
class Quiz2 extends QuizBase {

  @override
  // ルーティングのパス
  static const path = '/2';

  @override
  // 問題文
  String question = "スピッツの曲を選べ（１つは不正解）";

  @override
  // 選択肢カード
  List<Map<String, String>> choices = [
    {
      "choice": "夜を駆ける",
      "explanation" : "2002年発売",
      "answer": "true"
    },
    {
      "choice": "おっぱい",
      "explanation" : "1999年発売",
      "answer": "true"
    },
    {
      "choice": "ナンプラー\n日和",
      "explanation" : "2005年発売",
      "answer": "true"
    },
    {
      "choice": "1987→",
      "explanation" : "2017年発売",
      "answer": "true"
    },
    {
      "choice": "孫悟空",
      "explanation" : "2004年発売",
      "answer": "true"
    },
    {
      "choice": "トンボ\n飛べなかった",
      "explanation" : "正：「トンビ飛べなかった」",
      "answer": "false"
    }
  ];
}
import 'package:flutter/material.dart';
import 'quiz_base.dart';

///
/// 2問目のドボン問題クラス
/// 
/// オーバーライド必須
/// - [path] ルーティングパス 
/// - [question] 問題文 
/// - [choices] 選択肢カード

class Quiz2 extends QuizBase {
  Quiz2({Key? key}) : super(key: key);

  /// ルーティングのパス
  static const String path = '/2';

  /// 問題文
  final String question = "スピッツの曲を選べ（１つは不正解）";

  /// 選択肢カード
  final List<Map<String, String>> choices = [
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
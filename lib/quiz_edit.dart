//import 'dart:html';

import 'package:flutter/material.dart';

/// クイズ作成ページ
/// 
/// クイズの追加・削除・保存・ロードなど

class QuizEdit extends StatefulWidget {
  const QuizEdit({Key? key}) : super(key: key);

  final String title = 'クイズ作成';
  static const String path = '/edit/';

  @override
  State<QuizEdit> createState() => _QuizEditState();
}

class _QuizEditState extends State<QuizEdit> {

  /// 選択肢
  List<Map<String, String>> questions = [
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
  /// 問題番号
  int questionNumber = 0;

  /// 問題入力欄Widget
  Widget questionTextField(int questionNum){
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: TextField(
        controller: TextEditingController(text: questions[questionNum]['question']), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '問題',
        ),
        onChanged: (String value){
          print("問題 : ${value}");
          questions[questionNum]['question'] = value;        
        },
      )          
    );
  }

  /// 選択肢入力欄Widget
  Widget choiceTextField(int questionNum, int choiceNum){
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: TextField(
        controller: TextEditingController(text: questions[choiceNum]['choice']), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '選択肢',
        ),
        onChanged: (String value){
          print("選択肢${choiceNum} : ${value}");
          questions[choiceNum]['choice'] = value;
        },
      )
    );
  }

  ///解説入力欄Widget
  Widget explainTextField(int questionNum, int choiceNum){
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 10),
      child: TextField(
        controller: TextEditingController(text: questions[choiceNum]['explanation']), 
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '解説',
        ),
        onChanged: (String value){
          print("解説${choiceNum} : ${value}");
          questions[choiceNum]['explanation'] = value;
        },
      )          
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:ListView (
        children: <Widget>[
          const Text("問題"),
          questionTextField(questionNumber),
          const Text("選択肢"),
          choiceTextField(questionNumber, 0),
          explainTextField(questionNumber, 0),
          choiceTextField(questionNumber, 1),
          explainTextField(questionNumber, 1),
          choiceTextField(questionNumber, 2),
          explainTextField(questionNumber, 2),
          choiceTextField(questionNumber, 3),
          explainTextField(questionNumber, 3),
          choiceTextField(questionNumber, 4),
          explainTextField(questionNumber, 4),
          choiceTextField(questionNumber, 5),
          explainTextField(questionNumber, 5),
        ],
      ),
      // クイズ保存ボタン
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        onPressed: (){
          print("保存する処理を実装する");
        },
      ) 
    );
  }
}